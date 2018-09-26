//
//  ViewController.swift
//  Set
//
//  Created by Tommy Howell on 8/25/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    
    @IBOutlet var cardButtons: [CardButton]!
    
    var firstBlankCardButton: CardButton? {
        for card in cardButtons {
            if card.isBlankCard {
                return card
            }
        }
        return nil
    }
    
    private var game = Set()

    @IBOutlet weak var dealButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    fileprivate func setBlankCard(_ button: CardButton) {
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.symbol = -1
        button.style = -1
        button.number = -1
        button.isBlankCard = true
        button.isHint = false
//        button.isHidden = true
        button.isEnabled = false
    }
    
    fileprivate func setButtonWithCard(cardButton: CardButton, card: Card) {
        
        if card.isBlankCard
        {
            setBlankCard(cardButton)
            return
        }
        cardButton.isHidden = false
        cardButton.isEnabled = true
        cardButton.isBlankCard = false
        cardButton.cardSelected = game.cardIsSelected(card: card)
        cardButton.color = SettingsSingleton.settingsSingleton.getColors()[card.color]
        cardButton.symbol = card.symbol
        cardButton.style = card.shade
        cardButton.number = card.number
        
//        cardButton.layer.borderWidth = 2.0
//        cardButton.layer.borderColor = UIColor.blue.cgColor
//        cardButton.layer.cornerRadius = 5.0
//        if game.cardIsSelected(card: card)
//        {
//            cardButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        }
//        else
//        {
//            cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//        }
    }
    
    @IBAction func startGameButtonPressed(_ sender: Any) {
        startGameButton.isHidden = true
        game.start()
        dealButton.isHidden = false
        dealButton.isEnabled = true
        updateViewFromModel()
    }
    
    @IBAction func cardButtonTouched(_ sender: CardButton) {
        print("in cardButtonTouched")
        if let cardNumber = cardButtons.index(of: sender) {
            print("card \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in cardButtons")
        }
    }
    func updateViewFromModel(hint: Int? = nil){
        let cards = game.getCardsInPlay()
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            if cards.count > index
            {
                setButtonWithCard(cardButton: button, card: cards[index])
            } else {
                setBlankCard(button)
            }
        }
        if game.hasSetInPlay()
        {
            hintButton.isHidden = false
            hintButton.isEnabled = true
            if (hint != nil)
            {
                cardButtons[hint!].isHint = true
                hintButton.isEnabled = false
            } else {
                for cardButton in cardButtons {
                    cardButton.isHint = false
                }
            }
        }
        else
        {
            hintButton.isHidden = true
        }
    }
    
    func animateDrawCard(with cards: [Card]) {
        for _ in cards {
            if let cardButton = firstBlankCardButton {
                UIView.transition(with: cardButton,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: {cardButton.isBlankCard = !cardButton.isBlankCard})
            }
        }
    }
    
    @IBAction func dealButtonPressed(_ sender: Any) {
        print("deal button pressed")
//        dealButton.backgroundColor = colors[0]
        if game.numberOfNonBlankCardsInPlay() < cardButtons.count {
            let newCards = game.deal(nubmerOfCards: 3)
            animateDrawCard(with: newCards)
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var hintButton: UIButton!
    
    @IBAction func hintButtonPressed(_ sender: Any) {
        print("hint button pressed")
        updateViewFromModel(hint: game.getHintIndex())
    }
}



