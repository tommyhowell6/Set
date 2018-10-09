//
//  HardModeSet.swift
//  Set
//
//  Created by Tommy Howell on 10/1/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import Foundation

class HardModeSet: Set {
    

    override func start() {
        
        super.start()
    }
    
    @objc override func runTimedCode() {
        addBonusPoints(add: -3)
    }
    
    override func deal(nubmerOfCards: Int) -> [Card] {
        var cardsToReturn = [Card]()
        if !hasSetInPlay() {
            cardsToReturn = super.deal(nubmerOfCards: nubmerOfCards)
        }
        return cardsToReturn
    }

}
