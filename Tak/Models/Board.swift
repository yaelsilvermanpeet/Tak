//
//  Board.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation


enum PlayerColor: String {
    case white = "W"
    case black = "B"
}

struct Position: Equatable {
    let x: Int
    let y: Int
}

class Board {
    private(set) var size: Int
    private(set) var grid: [[[Piece]]]
    private(set) var whitePieces: [Piece]
    private(set) var blackPieces: [Piece]
    
    init(size: Int) {
        guard size == 4 || size == 5 || size == 6 else {
            fatalError("Invalid board size. Must be 4x4, 5x5, or 6x6.")
        }
        self.size = size
        self.grid = Array(repeating: Array(repeating: [], count: size), count: size)
        self.whitePieces = []
        self.blackPieces = []
    }
    
    func placePiece(at position: Position, piece: Piece) {
        grid[position.x][position.y].append(piece)
        switch piece.player.color {
        case .white:
            whitePieces.append(piece)
        case .black:
            blackPieces.append(piece)
        }
    }
    
    func movePiece(from startPosition: Position, to endPosition: Position, count: Int, currentPlayer: Player) -> Bool {
        // Check if the starting position has enough pieces
        if grid[startPosition.x][startPosition.y].count < count {
            return false
        }
        
        // Check if the piece belongs to the current player
        let movingPiece = grid[startPosition.x][startPosition.y].last
        if movingPiece?.player != currentPlayer {
            return false
        }
        
        // Check destination stack conditions
        let destinationStack = grid[endPosition.x][endPosition.y]
        if let topPiece = destinationStack.last {
            if topPiece.player != currentPlayer {
                if topPiece.type == .standing && movingPiece?.type != .capstone {
                    return false
                } else if topPiece.type == .capstone {
                    return false
                }
            }
        }
        
        // Move the piece
        let movedPieces = grid[startPosition.x][startPosition.y].suffix(count)
        grid[startPosition.x][startPosition.y].removeLast(count)
        grid[endPosition.x][endPosition.y].append(contentsOf: movedPieces)
        
        return true
    }
    
    
    
    // we need to adapt to board size, 4x4 , 5x5, 6x6
    func isRoadWin(for player: Player) -> Bool {
        func dfs(position: Position, visited: inout Set<Position>) -> Bool {
            if position.y == size - 1 {
                return true
            }
            
            visited.insert(position)
            
            let neighbors = [
                Position(x: position.x - 1, y: position.y),
                Position(x: position.x + 1, y: position.y),
                Position(x: position.x, y: position.y - 1),
                Position(x: position.x, y: position.y + 1)
            ]
            
            for neighbor in neighbors {
                if isValidPosition(neighbor) && !visited.contains(neighbor) {
                    if let topPiece = grid[neighbor.x][neighbor.y].last, topPiece.player == player, topPiece.type != .standing {
                        if dfs(position: neighbor, visited: &visited) {
                            return true
                        }
                    }
                }
            }
            
            return false
        }
        
        func isValidPosition(_ position: Position) -> Bool {
            return position.x >= 0 && position.x < size && position.y >= 0 && position.y < size
        }
        
        for x in 0..<size {
            if let startingPiece = grid[x][0].last, startingPiece.player == player, startingPiece.type != .standing {
                var visited = Set<Position>()
                if dfs(position: Position(x: x, y: 0), visited: &visited) {
                    return true
                }
            }
        }
        
        return false
    }
    
    
    
    func isFlatWin(for player: Player) -> Bool {
        var playerFlatCount = 0
        var opponentFlatCount = 0
        
        for x in 0..<size {
            for y in 0..<size {
                if let topPiece = grid[x][y].last {
                    if topPiece.player == player && topPiece.type != .standing {
                        playerFlatCount += 1
                    } else if topPiece.player != player && topPiece.type != .standing {
                        opponentFlatCount += 1
                    }
                }
            }
        }
        
        return playerFlatCount > opponentFlatCount
    }
    
    
    func isGameOver() -> (isOver: Bool, winner: Player?) {
        let players = [whitePieces.first?.player, blackPieces.first?.player].compactMap { $0 }
        
        for player in players {
            if isRoadWin(for: player) {
                return (isOver: true, winner: player)
            }
        }
        
        let totalPieces = whitePieces.count + blackPieces.count
        let maxPieces = size * size
        if totalPieces == maxPieces {
            for player in players {
                if isFlatWin(for: player) {
                    return (isOver: true, winner: player)
                }
            }
            return (isOver: true, winner: nil) // It's a draw
        }
        
        // Check if there are any remaining pieces or valid moves
        if hasRemainingPieces() || hasValidMoves() {
            return (isOver: false, winner: nil)
        }
        
        // If there are no remaining pieces or valid moves, determine the winner by flat win
        for player in players {
            if isFlatWin(for: player) {
                return (isOver: true, winner: player)
            }
        }
        
        return (isOver: true, winner: nil) // It's a draw
    }
    
    func hasRemainingPieces() -> Bool {
        let maxPieceCount = (size * size) / 2
        return whitePieces.count < maxPieceCount || blackPieces.count < maxPieceCount
    }
    
    func hasValidMoves() -> Bool {
        for x in 0..<size {
            for y in 0..<size {
                let currentPosition = Position(x: x, y: y)
                if let movingPiece = grid[x][y].last {
                    let currentPlayer = movingPiece.player
                    let neighbors = [
                        Position(x: x - 1, y: y),
                        Position(x: x + 1, y: y),
                        Position(x: x, y: y - 1),
                        Position(x: x, y: y + 1)
                    ]
                    
                    for neighbor in neighbors {
                        if isValidPosition(neighbor) {
                            let destinationStack = grid[neighbor.x][neighbor.y]
                            if let topPiece = destinationStack.last {
                                if topPiece.player == currentPlayer || (movingPiece.type == .capstone && topPiece.type == .standing) {
                                    return true
                                }
                            } else {
                                return true
                            }
                        }
                    }
                }
            }
        }
        
        return false
    }

    func isValidPosition(_ position: Position) -> Bool {
        return position.x >= 0 && position.x < size && position.y >= 0 && position.y < size
    }

    
}
