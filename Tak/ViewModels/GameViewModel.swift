//
//  GameViewModel.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var boardViewModel: BoardViewModel
    @Published var userViewModel: UserViewModel
    @Published var player1: Player
    @Published var player2: Player
    @Published var currentPlayer: Player
    
    init(boardViewModel: BoardViewModel, userViewModel: UserViewModel, player1: Player, player2: Player) {
        self.boardViewModel = boardViewModel
        self.userViewModel = userViewModel
        self.player1 = player1
        self.player2 = player2
        self.currentPlayer = player1
    }
    
    func startNewGame() {
        // Reset the board
        boardViewModel.board = Board(size: 5) // Assume you have a Board model with a size parameter
        // Reset the players
        player1 = Player(name: userViewModel.userProfile?.username ?? "Player 1")
        player2 = Player(name: "Player 2")
        currentPlayer = player1
    }
    
    func switchPlayer() {
        currentPlayer = currentPlayer === player1 ? player2 : player1
    }
}
