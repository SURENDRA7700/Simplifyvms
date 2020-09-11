//
//  BlogCell.swift
//  ketoGinik
//
//  Created by surendra kumar k on 12/06/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {

    @IBOutlet weak var foodInfoLabel: UILabel!
    @IBOutlet weak var foodDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


