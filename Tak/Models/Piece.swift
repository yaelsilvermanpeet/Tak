//
//  Piece.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation

enum Piece: String {
    case capstone
    case flat
    case standing
    
    func canFlatten() -> Bool {
        switch self {
        case .capstone:
            return true
        case .flat, .standing:
            return false
        }
    }
    
    func isPartOfRoad() -> Bool {
        switch self {
        case .capstone, .flat:
            return true
        case .standing:
            return false
        }
    }
}

class Piece {
    let player: Player
    let type: PieceType
    
    init(player: Player, type: PieceType) {
        self.player = player
        self.type = type
    }
    
    func canMoveOnTop(of piece: Piece) -> Bool {
        switch type {
        case .capstone:
            return true
        case .flat, .standing:
            return piece.type != .standing
        }
    }
    
    func canFlattenPiece(_ piece: Piece) -> Bool {
        return type.canFlatten() && piece.type == .standing
    }
    
    func isPartOfRoad() -> Bool {
        return type.isPartOfRoad()
    }
}

class Player {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
