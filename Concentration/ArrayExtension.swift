//
//  ArrayExtension.swift
//  Concentration
//
//  Created by Joanna Skotarczyk on 27/04/2018.
//  Copyright © 2018 Joanna Skotarczyk. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
