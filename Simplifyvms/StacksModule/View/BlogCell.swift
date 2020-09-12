//
//  BlogCell.swift
//  ketoGinik
//
//  Created by surendra kumar k on 12/06/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsView: UITextView!
    @IBOutlet weak var blogBtn: BlogBuuton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class BlogBuuton: UIButton {
    var eachItem: Item?
}
