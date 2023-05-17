//
//  BoardView.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI

struct BoardView: View {
    @ObservedObject var board: Board
    
    var body: some View {
        VStack {
            ForEach(0..<board.size, id: \.self) { i in
                HStack {
                    ForEach(0..<board.size, id: \.self) { j in
                        SquareView(pieces: board.grid[i][j])
                    }
                }
            }
        }
    }
}

struct SquareView: View {
    var pieces: [Piece]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 50, height: 50)
            
            if let topPiece = pieces.last {
                Text(topPiece.type.rawValue)
                    .foregroundColor(topPiece.player.color == .white ? .white : .black)
            }
        }
    }
}

