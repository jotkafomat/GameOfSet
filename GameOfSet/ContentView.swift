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
                        withAnimation { game.touch(card) }
                    }
                    .transition(
                        AnyTransition.move(
                            edge: Edge
                                .allCases
                                .randomElement()!)
                            .animation(.spring(response: 2.5, dampingFraction: 4.6, blendDuration: 30))
                    )
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation { game.startGame() }                    
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { withAnimation { game.newGame() } },
                                label: { Text("New Game") }),
                trailing: Button(action: { withAnimation {game.deal3MoreCards() }},
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
