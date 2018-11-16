//
//  HighScoreTableViewCell.swift
//  Set
//
//  Created by Tommy Howell on 11/13/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel! { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBOutlet weak var name: UILabel! { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBOutlet weak var score: UILabel! { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
