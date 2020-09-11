//
//  ViewController.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 11/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.tintColor = UIColor.Simplify.Blue
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let stockVC = storyboard.instantiateViewController(withIdentifier: "StacksVC") as? StacksVC
        let stockTab = UINavigationController(rootViewController: stockVC!)
        stockTab.tabBarItem.image = UIImage(named: "stockTab")?.withRenderingMode(.alwaysTemplate)
        stockTab.title = "Stacks"
        let itemInfoVC = storyboard.instantiateViewController(withIdentifier: "ItemInfoVC") as? ItemInfoVC
        let infoTab = UINavigationController(rootViewController: itemInfoVC!)
        infoTab.tabBarItem.image = UIImage(named: "infoTab")?.withRenderingMode(.alwaysTemplate)
        infoTab.title = "Info"
        
        self.tabBar.unselectedItemTintColor = UIColor.Simplify.Black
        viewControllers = [stockTab,infoTab]
        for vc in self.viewControllers! {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }

    }


}

