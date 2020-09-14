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
                catch let error as NSError {
                    print(error.localizedDescription)
                    DispatchQueue.main.async() {
                        self.removeActivityindicator(indicator: activityIndicatorObj)
                        ErrorManager.showErrorAlert(mainTitle: "Alert", subTitle: error.localizedDescription)
                    }
                }
            }.resume()
        }else {
            ErrorManager.showErrorAlert(mainTitle: "Alert", subTitle: "Internet Connection not Available")
        }
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
