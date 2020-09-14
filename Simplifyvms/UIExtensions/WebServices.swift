//
//  WebServices.swift
//  GLogin
//
//  Created by surendra kumar k on 14/08/19.
//  Copyright © 2019 surendra kumar k. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard
let kToken = ""


class WebServices: NSObject {
   static let shared = WebServices()
    var userCartData : [Item]? = []

    private override init() {}
    
    //MARK:- Post request call
    func postServiceCall<T: Codable>(type: T.Type, urlString: String, requiredToken: Bool, parameters: [String:Any], view: UIView, animateIndicator: Bool, completion completionHandler: @escaping(T?,Error?) -> Void)
    {
        if (NetworkManager.sharedInstance.reachability.isReachable) {
            print("Internet Connection Available!")
            var activityIndicatorObj = UIActivityIndicatorView()
            DispatchQueue.main.async {
                activityIndicatorObj = self.showActivityIndicator(view: view, animate:true)
            }
            
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
            request.httpBody = httpBody;
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            if requiredToken {
                let tokenStr = "Bearer \(defaults.object(forKey: kToken)!) "
                request.setValue(tokenStr, forHTTPHeaderField: "Authorization")
            }
            request.timeoutInterval = 120
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data else {return}
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: responseData)
                    completionHandler(jsonData,error)
                    self.removeActivityindicator(indicator: activityIndicatorObj)
                }
                catch {
                    self.removeActivityindicator(indicator: activityIndicatorObj)
                    completionHandler(nil,error)
                }
                self.removeActivityindicator(indicator: activityIndicatorObj)
            }.resume()
            
        }else{
            print("Internet Connection not Available!")
            self.showAlertWithYESNO(title: "Alert", message: "Internet Connection not Available", isConditional: false, prentview: view)
            { (ISYESNO) in
                completionHandler(nil,nil)
            }
        }
    }

    
    func getServiceCall<T:Codable>(type : T.Type,urlString : String,requiredToken: Bool, view: UIView, animateIndicator: Bool,complete CompletionHandler : @escaping(T?)->Void)
    {
        if (NetworkManager.sharedInstance.reachability.isConnectedToNetwork)() {
            var activityIndicatorObj = UIActivityIndicatorView()
            DispatchQueue.main.async {
                activityIndicatorObj = self.showActivityIndicator(view: view, animate:true)
            }
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            if requiredToken {
                let tokenStr = "Bearer \(defaults.object(forKey: kToken)!)"
                request.setValue(tokenStr, forHTTPHeaderField: "Authorization")
            }
            request.timeoutInterval = 120.0
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: responseData)
                    self.removeActivityindicator(indicator: activityIndicatorObj)
                    CompletionHandler(jsonData)
                }
                catch {
                    self.removeActivityindicator(indicator: activityIndicatorObj)
                }
            }.resume()
        }else {
            ErrorManager.showErrorAlert(mainTitle: "Alert", subTitle: "Internet Connection not Available")
        }
    }
    
   
    func showAlertWithYESNO(title: String, message: String, isConditional: Bool, prentview: UIView, completionBlock: @escaping (_: Bool) -> Void) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           
           // Check whether it's conditional or not ('YES' 'NO, or just 'OK')
           if isConditional
           {
               alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                   alert.dismiss(animated: true, completion: nil)
                   completionBlock(true)
               }))
               
               alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                   alert.dismiss(animated: true, completion: nil)
                   completionBlock(false)
               }))
           }
           else
           {
               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "ok"), style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
                   alert.dismiss(animated: true, completion: nil)
                   completionBlock(true)
               }))
           }
           
           alert.show()
       }
}





public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1  // Swift 3-4: UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

extension NSObject {
    func showActivityIndicator(view: UIView, animate: Bool) -> UIActivityIndicatorView {
        let myActivityIndicator = UIActivityIndicatorView(style: .gray)
        myActivityIndicator.color = .black
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        if animate {
            myActivityIndicator.startAnimating()
        } else {
            myActivityIndicator.stopAnimating()
        }
        view.addSubview(myActivityIndicator)
        return myActivityIndicator
    }
    
    func removeActivityindicator(indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
        }
    }
    
    func removeActivityindicatorWithDelay(indicator: UIActivityIndicatorView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            indicator.stopAnimating()
        })
        
    }
}


extension UIViewController
{
    func viewLayout(view:UIView,top:NSLayoutYAxisAnchor,bottom:NSLayoutYAxisAnchor,leading:NSLayoutXAxisAnchor,trailing:NSLayoutXAxisAnchor)
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalToSystemSpacingBelow: top, multiplier: 0).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: bottom, multiplier: 0).isActive = true
        view.leadingAnchor.constraint(equalToSystemSpacingAfter: leading, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: trailing, multiplier: 0).isActive = true
    }
}
