//
//  Card+Shading.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import Foundation

extension Card {
    
    enum Shading {
        case solid
        case striped
        case open
    }
}
extension Card.Shading: CaseIterable {}
