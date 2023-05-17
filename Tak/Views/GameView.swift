//
//  GameView.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Game")
                .font(.largeTitle)
            
            BoardView(board: gameViewModel.board)
            
            HStack {
                Text("Player 1: \(gameViewModel.player1.name)")
                    .font(.title2)
                
                Text("Player 2: \(gameViewModel.player2.name)")
                    .font(.title2)
            }
            
            Button(action: {
                gameViewModel.startNewGame()
            }) {
                Text("Start New Game")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
