//
//  CardView.swift
//  Set
//
//  Created by Tommy Howell on 9/20/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

@IBDesignable
class CardButton: UIButton {
    
    @IBInspectable
    var symbol: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var number: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var style: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isBlankCard: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isHint: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var cardSelected: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    static func == (left: CardButton, right: CardButton) -> Bool
    {
        return left.symbol == right.symbol && left.color == right.color && left.number == right.number && left.style == right.style
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if isBlankCard {
            return
        }
        let path = UIBezierPath()
        let offsetForThreeShapes = bounds.width/18
        let border = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        border.lineWidth = 2.0
        
        if cardSelected {
            #colorLiteral(red: 0.5194903016, green: 0.9142541289, blue: 0.7371789217, alpha: 1).setFill()
            border.fill()
        } else {
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).setFill()
            border.fill()
        }
        UIColor.blue.setStroke()
        border.stroke()
        
        if isHint {
            let hint = UIBezierPath(arcCenter: CGPoint(x: bounds.width/12, y: bounds.height * (6/7)),
                                    radius: bounds.width/36,
                                    startAngle: 0,
                                    endAngle: CGFloat.pi * 2,
                                    clockwise: true)
            UIColor.red.setFill()
            hint.fill()
        }
        
        if symbol == 0 {
            if number == 0 {
                path.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            } else if number == 1 {
                path.move(to: CGPoint(x: bounds.width * (11 / 24), y: bounds.height/2))
                path.addArc(withCenter: CGPoint(x: bounds.width * (1 / 3), y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                path.move(to: CGPoint(x: bounds.width * (19 / 24), y: bounds.height/2))
                path.addArc(withCenter: CGPoint(x: bounds.width * (2 / 3), y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            } else if number == 2 {
                path.move(to: CGPoint(x: bounds.width * (3 / 8) - offsetForThreeShapes, y: bounds.height/2))
                path.addArc(withCenter: CGPoint(x: bounds.width * (1 / 4) - offsetForThreeShapes, y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                path.move(to: CGPoint(x: bounds.width * (5 / 8), y: bounds.height/2))
                path.addArc(withCenter: CGPoint(x: bounds.width * (1 / 2), y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                path.move(to: CGPoint(x: bounds.width * (7 / 8) + offsetForThreeShapes, y: bounds.height/2))
                path.addArc(withCenter: CGPoint(x: bounds.width * (3 / 4) + offsetForThreeShapes, y: bounds.height/2), radius: bounds.width/8, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            }
        } else if symbol == 1 {
            if number == 0 {
                path.move(to: CGPoint(x: bounds.width * (3 / 8), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (3 / 8), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (5 / 8), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (5 / 8), y: bounds.height * (1 / 3)))
                path.close()
            } else if number == 1 {
                path.move(to: CGPoint(x: bounds.width * (5 / 24), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (5 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (11 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (11 / 24), y: bounds.height * (1 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (13 / 24), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (13 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (19 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (19 / 24), y: bounds.height * (1 / 3)))
                path.close()
            } else if number == 2 {
                path.move(to: CGPoint(x: bounds.width * (3 / 24) - offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (3 / 24) - offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (9 / 24) - offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (9 / 24) - offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (9 / 24), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (9 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (15 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (15 / 24), y: bounds.height * (1 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (15 / 24) + offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (15 / 24) + offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (21 / 24) + offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (21 / 24) + offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.close()
            }
        } else if symbol == 2 {
            if number == 0 {
                path.move(to: CGPoint(x: bounds.width / 2, y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (3 / 8), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (5 / 8), y: bounds.height * (2 / 3)))
                path.close()
            } else if number == 1 {
                path.move(to: CGPoint(x: bounds.width * (1 / 3), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (5 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (11 / 24), y: bounds.height * (2 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (2 / 3), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (13 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (19 / 24), y: bounds.height * (2 / 3)))
                path.close()
            } else if number == 2 {
                path.move(to: CGPoint(x: bounds.width * (1 / 4) - offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (3 / 24) - offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (9 / 24) - offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (2 / 4), y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (9 / 24), y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (15 / 24), y: bounds.height * (2 / 3)))
                path.close()
                path.move(to: CGPoint(x: bounds.width * (3 / 4) + offsetForThreeShapes, y: bounds.height * (1 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (15 / 24) + offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.addLine(to: CGPoint(x: bounds.width * (21 / 24) + offsetForThreeShapes, y: bounds.height * (2 / 3)))
                path.close()
            }
        }
        path.addClip()
        color.setStroke()
        path.stroke()
        if style == 0 {
            color.setFill()
            path.fill()
        } else if style == 1 {
            let numberOfStripes = 10
            let increaseY = bounds.height/CGFloat(numberOfStripes)
            let increaseX = bounds.width/CGFloat(numberOfStripes)
            for i in 1...numberOfStripes {
                let line = UIBezierPath()
                let y = CGFloat(i) * increaseY
                let x = CGFloat(i) * increaseX
                line.move(to: CGPoint(x: x, y: 0))
                line.addLine(to: CGPoint(x: 0, y: y))
                
                line.move(to: CGPoint(x: bounds.width - x, y: bounds.height))
                line.addLine(to: CGPoint(x: bounds.width, y: bounds.height - y))
                
                line.stroke()
            }
        }
    }
}
