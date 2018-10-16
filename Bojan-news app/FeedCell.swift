//
//  FeedCell.swift
//  Bojan-news app
//
//  Created by Josip Vukovic on 16/10/2018.
//  Copyright © 2018 Josip Vukovic. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var slika: UIImageView!
    @IBOutlet weak var datum: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
