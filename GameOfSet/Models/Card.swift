//
//  Card.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import Foundation

struct Card {
    
    let shape: Shape
    let number: Number
    let color: Color
    let shading: Shading
    var isDealt: Bool = false
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    //array of all 81 unique cards
    static var newDeck: [Card] {
        var deck = [Card]()
        for shape in Shape.allCases {
            for number in Number.allCases {
                for color in Color.allCases {
                    for shading in Shading.allCases {
                        deck.append(Card(shape: shape,
                                         number: number,
                                         color: color,
                                         shading: shading))
                    }
                }
            }
        }
        return deck
    }
    
    func matches(_ other: Card) -> Bool {
        color == other.color &&
            shape == other.shape &&
            number == other.number &&
            shading == other.shading
    }
}

extension Card: Hashable {}
