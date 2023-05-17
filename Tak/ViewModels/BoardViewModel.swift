//
//  BoardViewModel.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI
import Combine

class BoardViewModel: ObservableObject {
    @Published var board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    func placePiece(at position: Position, piece: Piece) {
        if board.isValidPosition(position) && board.hasRemainingPieces() {
            board.placePiece(at: position, piece: piece)
        }
    }
    
    func movePiece(from startPosition: Position, to endPosition: Position, count: Int, currentPlayer: Player) {
        if board.isValidPosition(startPosition) && board.isValidPosition(endPosition) {
            _ = board.movePiece(from: startPosition, to: endPosition, count: count, currentPlayer: currentPlayer)
        }
    }
    
    func isGameOver() -> (isOver: Bool, winner: Player?) {
        return board.isGameOver()
    }
}
