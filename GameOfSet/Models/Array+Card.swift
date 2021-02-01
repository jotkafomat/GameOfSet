//
//  Array+Card.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 01/02/2021.
//

import Foundation

extension Array where Element == Card {

    var areValidSet: Bool {
        guard count == 3 else { return false }
        
        //all the same or all diffrent
        let colorsAreSet = Set(map(\.color)).count != 2
        let shapesAreSet = Set(map(\.shape)).count != 2
        let numbersAreSet = Set(map(\.number)).count != 2
        let shadingsAreSet = Set(map(\.shading)).count != 2
        
        return colorsAreSet && shapesAreSet && numbersAreSet && shadingsAreSet
    }

}
