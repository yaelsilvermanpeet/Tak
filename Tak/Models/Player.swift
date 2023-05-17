//
//  Player.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation

class Player {
    let name: String
    var remainingFlats: Int
    var remainingStandingStones: Int
    var remainingCapstones: Int
    
    init(name: String, remainingFlats: Int, remainingStandingStones: Int, remainingCapstones: Int) {
        self.name = name
        self.remainingFlats = remainingFlats
        self.remainingStandingStones = remainingStandingStones
        self.remainingCapstones = remainingCapstones
    }
    
    func updateRemainingPieces(pieceType: PieceType, increase: Bool) {
        switch pieceType {
        case .flat:
            remainingFlats += increase ? 1 : -1
        case .standing:
            remainingStandingStones += increase ? 1 : -1
        case .capstone:
            remainingCapstones += increase ? 1 : -1
        }
    }
}
