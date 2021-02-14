//
//  Card+Number.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import Foundation

extension Card {
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
    }
}

extension Card.Number: CaseIterable {}
