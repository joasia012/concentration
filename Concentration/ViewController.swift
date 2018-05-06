//
//  ViewController.swift
//  Concentration
//
//  Created by Joanna Skotarczyk on 14/04/2018.
//  Copyright © 2018 Joanna Skotarczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
//    private(set) var flipCount = 0 {
//        didSet {
//            flipCountLabel.text = "Flips \(flipCount)"
//        }
//    }
//
//    private(set) var score = 0 {
//        didSet {
//            scoreLabel.text = "Score \(score)"
//        }
//    }
//    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction private func newGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        emoji.removeAll()
        emojiSet = emojiChoices[emojiChoices.count.arc4random]
        game.startNewGame()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiChoices.append(emojiHalloween)
        emojiChoices.append(emojiJunkFood)
        emojiChoices.append(emojiSports)
        emojiChoices.append(emojiAnimals)
        emojiChoices.append(emojiMusic)
        emojiChoices.append(emojiFaces)
        emojiSet = emojiChoices[emojiChoices.count.arc4random]
        game.scoreDidChange = { [weak self] score in
            self?.scoreLabel.text = "Score: \(score)"
        }
        game.flipCountDidChange = { [weak self] flipCount in
            self?.flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    private var emojiHalloween = ["🎃","👻","😱","😈","🙀","🦇","🍎","🍭","🍬"]
    private var emojiJunkFood = ["🍔","🍟","🍕","🌯","🌭","🥙","🥪","🥞","🍿"]
    private var emojiSports = ["🏄‍♂️","🏂","🏊‍♀️","🏋️‍♂️","⛷","🚴‍♀️","⛹️‍♂️","🏄‍♀️","🤽‍♂️"]
    private var emojiAnimals = ["🦉","🐬","🐫","🦔","🐈","🐟","🐁","🦋","🐞"]
    private var emojiMusic = ["🎤","🎧","🎼","🎹","🥁","🎷","🎺","🎸","🎻"]
    private var emojiFaces = ["🙈","🙉","🙊","🐵","🐷","🐻","🐼","🐱","🐭"]
    
    private var emojiChoices = [[String]]()
    private var emojiSet = [String]()
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiSet.count > 0 {
            let randomIndex = emojiSet.count.arc4random
            emoji[card.identifier] = emojiSet.remove(at: randomIndex)
        }
        return emoji[card.identifier]! ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
