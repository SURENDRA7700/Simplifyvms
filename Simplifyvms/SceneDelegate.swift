//
//  SceneDelegate.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 11/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import UIKit
import BackgroundTasks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        registerBackgroundTaks()
        registerLocalNotification()

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        cancelAllPandingBGTask()
        scheduleAppRefresh()
        scheduleItemFetcher()

        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
   
    private func registerBackgroundTaks() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.simplify.Itemfetcher", using: nil) { task in
            //This task is cast with processing request (BGProcessingTask)
            self.scheduleLocalNotification()
            self.handleItemefetcherTask(task: task as! BGProcessingTask)
        }
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.simplify.apprefresh", using: nil) { task in
            //This task is cast with processing request (BGAppRefreshTask)
            self.scheduleLocalNotification()
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
    }
}

//MARK:- BGTask Helper
extension SceneDelegate {
    
    func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    func scheduleItemFetcher() {
        let request = BGProcessingTaskRequest(identifier: "com.simplify.Itemfetcher")
        request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = false
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule image featch: \(error)")
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.simplify.apprefresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 2 * 60) // App Refresh after 2 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        //Todo Work
        /*
         //AppRefresh Process
         */
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        scheduleLocalNotification()
        //
        task.setTaskCompleted(success: true)
    }
    
    func handleItemefetcherTask(task: BGProcessingTask) {
        scheduleItemFetcher() // Recall
        //Todo Work
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        //webservice call to get items
        let url : String? = "\(BlogsInfoUrl)\(1)"
        WebServices.shared.getServiceCall(type: BlogStocksModel.self, urlString: url!, requiredToken: false, view: UIView(), animateIndicator: true)
        {  (response) in
            NotificationCenter.default.post(name: .newItemsFetched,
                                            object: self,
                                            userInfo: ["items": response as Any])
        }
        task.setTaskCompleted(success: true)
    }
}

extension Notification.Name {
  static let newItemsFetched = Notification.Name("com.andyibanez.newPokemonFetched")
}


//MARK:- Notification Helper

extension SceneDelegate {
    
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.fireNotification()
            }
        }
    }
    
    func fireNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Bg"
        notificationContent.body = "BG Notifications."
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
}
