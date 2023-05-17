//
//  GameController.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI
import Combine

class GameController {
    var gameViewModel: GameViewModel
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
    }
    
    func placePiece(at position: Position, piece: Piece) {
        gameViewModel.boardViewModel.placePiece(at: position, piece: piece)
        if gameViewModel.boardViewModel.isGameOver().isOver {
            print("Game over! Winner is \(gameViewModel.boardViewModel.isGameOver().winner?.name ?? "none")")
        } else {
            gameViewModel.switchPlayer()
        }
    }
    
    func movePiece(from startPosition: Position, to endPosition: Position, count: Int) {
        gameViewModel.boardViewModel.movePiece(from: startPosition, to: endPosition, count: count, currentPlayer: gameViewModel.currentPlayer)
        if gameViewModel.boardViewModel.isGameOver().isOver {
            print("Game over! Winner is \(gameViewModel.boardViewModel.isGameOver().winner?.name ?? "none")")
        } else {
            gameViewModel.switchPlayer()
        }
    }
}
