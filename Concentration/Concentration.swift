//
//  Concentration.swift
//  Concentration
//
//  Created by Joanna Skotarczyk on 23/04/2018.
//  Copyright © 2018 Joanna Skotarczyk. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    var score: Int = 0
    private var alreadySeen = [Int]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func startNewGame() {
        alreadySeen.removeAll()
        cards.shuffle()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
     
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIntex = indexOfOneAndOnlyFaceUpCard, matchIntex != index {
                if cards[matchIntex].identifier == cards[index].identifier {
                    cards[matchIntex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    
                    if alreadySeen.contains(matchIntex) {
                        score -= 1
                    } else {
                        alreadySeen.append(matchIntex)
                    }
                    if alreadySeen.contains(index) {
                        score -= 1
                    } else {
                        alreadySeen.append(index)
                    }
                }
                cards[index].isFaceUp = true
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
