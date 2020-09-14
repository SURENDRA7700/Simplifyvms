//
//  EmptyStateView.swift
//  eGroceryy
//
//  Created by Ajeet N on 27/06/19.
//  Copyright © 2019 Ajeet N. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    @IBOutlet var headerTitle: UILabel!
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var stateAction: UIButton!
    
    func values(headerTitle:String,stateImage:UIImage,title:String,subTitle:String,stateActionTitle:String)
    {
        DispatchQueue.main.async {
            self.headerTitle.text = headerTitle
            self.stateImage.image = stateImage
            self.title.text = title
            self.subTitle.text = subTitle
            self.stateAction.setTitle(stateActionTitle, for: .normal)
        }
    }
    
}
