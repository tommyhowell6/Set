//
//  HighScoreLabel.swift
//  Set
//
//  Created by Tommy Howell on 10/3/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class HighScoreLabel: UIView {

    var name: String = "Tommy" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var score: Int = 100 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
