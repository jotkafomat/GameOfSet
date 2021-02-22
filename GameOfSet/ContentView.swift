//
//  ContentView.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var game = GameEngine()
    
    var body: some View {
        NavigationView {
            GridView(game.dealtCards) { card in
                CardView(card: card)
                    .onTapGesture {
                        game.touch(card)
                    }
            }
            .onAppear {
                game.startGame()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: game.newGame,
                                label: { Text("New Game") }),
                trailing: Button(action: game.deal3MoreCards,
                                 label: { Text("Add 3 cards") })
                    .disabled(!game.canDealMoreCards)
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
