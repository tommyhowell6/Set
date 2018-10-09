//
//  HighScoreView.swift
//  Set
//
//  Created by Tommy Howell on 10/3/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class HighScoreView: UIView {

    var highScores: [HighScoreLabel]? { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
