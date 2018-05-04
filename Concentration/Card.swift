//
//  Card.swift
//  Concentration
//
//  Created by Joanna Skotarczyk on 23/04/2018.
//  Copyright © 2018 Joanna Skotarczyk. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
