//
//  Concentration.swift
//  Concentration
//
//  Created by Joanna Skotarczyk on 23/04/2018.
//  Copyright © 2018 Joanna Skotarczyk. All rights reserved.
//

import Foundation

// dlaczego to jest strukturą?
struct Concentration {
    
    private(set) var cards = [Card]()
    
    // nie rozumiem jak to dziala
    var scoreDidChange: ((Int) -> Void)?
    
    var score: Int = 0 {
        didSet {
            scoreDidChange?(score)
        }
    }
    
    var flipCountDidChange: ((Int) -> Void)?
    
    var flipCount: Int = 0 {
        didSet {
            flipCountDidChange?(flipCount)
        }
    }
    
    private var alreadySeen = [Int]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {
                cards[$0].isFaceUp
            }.oneAndOnly
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func startNewGame() {
        flipCount = 0
        score = 0
        alreadySeen.removeAll()
        cards.shuffle()
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
     
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    
                    if alreadySeen.contains(matchIndex) {
                        score -= 1
                    } else {
                        alreadySeen.append(matchIndex)
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

// ??
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
