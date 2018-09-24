//
//  Card.swift
//  Set
//
//  Created by Tommy Howell on 8/25/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import Foundation

class Card: Hashable, Equatable
{
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    let identifier: Int
    let color: Int
    let symbol: Int
    let shade: Int
    let number: Int
    let isBlankCard: Bool
    
    init(color: Int, symbol: Int, shade: Int, number: Int) {
        isBlankCard = false
        self.color = color
        self.symbol = symbol
        self.shade = shade
        self.number = number
        self.identifier = color * 1000 + symbol * 100 + shade * 10 + number
    }
    
    init(isBlankCard: Bool) {
        self.isBlankCard = isBlankCard
        self.color = 0
        self.symbol = 0
        self.shade = 0
        self.number = 0
        self.identifier = 0
    }
    
}
