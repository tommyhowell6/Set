//
//  HighScoreLabel.swift
//  Set
//
//  Created by Tommy Howell on 10/3/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

@IBDesignable
class HighScoreLabel: UIView {

    @IBInspectable
    var name: String = "Tommy" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var score: Int = 100 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var nameLabel = createCornerLabel()
    private lazy var scoreLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = name
        nameLabel.frame.size = CGSize.zero
        nameLabel.sizeToFit()
        nameLabel.frame.origin = bounds.origin
            .offsetBy(dx: 10.0, dy: bounds.height/2)
            .offsetBy(dx: 0, dy: -nameLabel.frame.size.height)
        
        scoreLabel.text = String(score)
        scoreLabel.frame.size = CGSize.zero
        scoreLabel.sizeToFit()
        scoreLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -1.0, dy: -1.0)
            .offsetBy(dx: -scoreLabel.frame.size.width, dy: -scoreLabel.frame.size.height)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
