//
//  Set.swift
//  Set
//
//  Created by Tommy Howell on 8/25/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import Foundation

class Set{
    
    let isTest = true

    private var cardsLeftInDeck = [Card]()
    private let numberOfCardsAtStart = 12
    private var cardsInPlay = [Card]()
    private var selectedCards = [Card]()
    private var hintCardIndices = [Int]()
    private var numberOfHints = 0
    private var numberOfMatchedSets = 0
    private var bonusPoints = 0
    private var wrongGuesses = 0

    var scoreValue: Int {
        return ((numberOfMatchedSets * 4) + bonusPoints) - (numberOfHints + wrongGuesses)
    }
    
    func score(user: String) -> Score {
        return (Score(numberOfHints: numberOfHints,
                      numberOfMatchedSets: numberOfMatchedSets,
                      bonusPoints: bonusPoints,
                      wrongGuesses: wrongGuesses,
                      user: user))
    }
//    let numberOfHints: Int
//    let numberOfMatchedSets: Int
//    let bonusPoints: Int
//    let wrongGuesses:  Int
//    let user: String
    
    init() {
        for color in 0..<3 {
            for symbol in 0..<3 {
                for shade in 0..<3 {
                    for number in 0..<3 {
                        cardsLeftInDeck.append(Card(color: color, symbol: symbol, shade: shade, number: number))
                    }
                }
            }
        }
        var last = cardsLeftInDeck.count - 1
        while last > 0 {
            cardsLeftInDeck.swapAt(last, last.arc4random)
            last -= 1
        }
    }
    
    func deal(nubmerOfCards: Int) -> [Card] {
        var cardsToReturn = [Card]()
        var tempCards = [Card]()
        for _ in 0..<nubmerOfCards
        {
            if cardsLeftInDeck.count > 0 {
                let card = cardsLeftInDeck.removeFirst()
                cardsToReturn.append(card)
                tempCards.append(card)
            }
        }
        for cardIndex in cardsInPlay.indices
        {
            if cardsInPlay[cardIndex].isBlankCard
            {
                if let cardToAdd = tempCards.popLast()
                {
                    cardsInPlay.remove(at: cardIndex)
                    cardsInPlay.insert(cardToAdd, at: cardIndex)
                }
            }
        }
        cardsInPlay.append(contentsOf: tempCards)
        return cardsToReturn
    }
    
    func start() {
        
        for _ in 0..<numberOfCardsAtStart
        {
            if cardsLeftInDeck.count > 0 {
                let card = cardsLeftInDeck.removeFirst()
                cardsInPlay.append(card)
            }
        }
    }
    
    func chooseCard(at cardsInPlayIndex: Int) {
        // selectedCards are the cards that are already selected
        // index is the index of the newly touched card into cardsInPlay
        for selectedCardsIndex in selectedCards.indices
        {
            if selectedCards[selectedCardsIndex] == cardsInPlay[cardsInPlayIndex]
            {
                //unselect
                selectedCards.remove(at: selectedCardsIndex)
                return
            }
        }
        
        selectedCards.append(cardsInPlay[cardsInPlayIndex])
        
        if selectedCards.count == 3 {
            if isSetSelected()
            {
                print("you found a set")
                replaceCardsWithBlanks()
            } else {
                wrongGuesses += 1
                
            }
            selectedCards = [Card]()
        }
        
    }
    
    func isSet(card1: Card, card2: Card, card3: Card) -> Bool {
        if card1.isBlankCard || card2.isBlankCard || card3.isBlankCard
        {
            return false
        }
        var isColorSet = false
        if card3.color == card1.color, card3.color == card2.color{
            isColorSet = true
        } else if card3.color != card1.color, card1.color != card2.color, card3.color != card2.color {
            isColorSet = true
        }
        var isShadeSet = false
        if card3.shade == card1.shade, card3.shade == card2.shade{
            isShadeSet = true
        } else if card3.shade != card1.shade, card1.shade != card2.shade, card3.shade != card2.shade {
            isShadeSet = true
        }
        var isSymbolSet = false
        if card3.symbol == card1.symbol, card3.symbol == card2.symbol{
            isSymbolSet = true
        } else if card3.symbol != card1.symbol, card1.symbol != card2.symbol, card3.symbol != card2.symbol {
            isSymbolSet = true
        }
        var isNumberSet = false
        if card3.number == card1.number, card3.number == card2.number{
            isNumberSet = true
        } else if card3.number != card1.number, card1.number != card2.number, card3.number != card2.number {
            isNumberSet = true
        }
        return isColorSet && isShadeSet && isSymbolSet && isNumberSet
    }
    
    func isSetSelected() -> Bool {
        if selectedCards.count != 3
        {
            return false
        }
        let allTrue = isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2])
        if allTrue {
            numberOfMatchedSets += 1
            if numberOfNonBlankCardsInPlay() <= 12 {
                bonusPoints += 2
                if numberOfNonBlankCardsInPlay() <= 9 {
                    bonusPoints += 2
                }
            }
        }
        return allTrue || isTest
    }
    
    func hasSetInPlay() -> Bool {
        
        for card1Index in cardsInPlay.indices
        {
            if !cardsInPlay[card1Index].isBlankCard
            {
                for card2Index in cardsInPlay.indices
                {
                    if card2Index > card1Index && !cardsInPlay[card2Index].isBlankCard
                    {
                        for card3Index in cardsInPlay.indices
                        {
                            if card3Index > card2Index && !cardsInPlay[card3Index].isBlankCard
                            {
                                if isSet(card1: cardsInPlay[card1Index], card2: cardsInPlay[card2Index], card3: cardsInPlay[card3Index])
                                {
                                    print("\(card1Index) \(card2Index) \(card3Index)")
                                    hintCardIndices = [card1Index, card2Index, card3Index]
                                    return true
                                }
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    func replaceCardsWithBlanks()
    {
        for cardIndex in cardsInPlay.indices {
            for setCardIndex in selectedCards.indices
            {
                if cardsInPlay[cardIndex] == selectedCards[setCardIndex]
                {
                    cardsInPlay.remove(at: cardIndex)
                    cardsInPlay.insert(Card(isBlankCard: true), at: cardIndex)
                }
            }
        }
    }
    
    func getCardsInPlay() -> [Card] {
        return cardsInPlay
    }
    
    func numberOfNonBlankCardsInPlay() -> Int {
        var numberInPlay = 0
        for card in cardsInPlay
        {
            if !card.isBlankCard
            {
                numberInPlay += 1
            }
        }
        return numberInPlay
    }
    
    func cardIsSelected(card: Card) -> Bool {
        return selectedCards.contains(card)
    }
    
    func getRandomHintIndex() -> Int? {
        numberOfHints += 1
        if hasSetInPlay()
        {
            return hintCardIndices[hintCardIndices.count.arc4random]
        }
        return nil
    }
    
    func isOutOfCards() -> Bool {
        if cardsLeftInDeck.count < 1 {
            bonusPoints += (24 - numberOfNonBlankCardsInPlay()) * 2
            return true
        }
        return false
    }
    
    func addBonusPoints(add numberOfPoint: Int) {
        bonusPoints += numberOfPoint
    }
    
    @objc func runTimedCode(){}
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}

