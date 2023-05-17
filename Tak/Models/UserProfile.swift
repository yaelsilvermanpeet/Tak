//
//  UserProfile.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation

class UserProfile {
    let username: String
    let email: String
    var gamesPlayed: Int
    var gamesWon: Int
    var player: Player
    
    init(username: String, email: String, gamesPlayed: Int = 0, gamesWon: Int = 0) {
        self.username = username
        self.email = email
        self.gamesPlayed = gamesPlayed
        self.gamesWon = gamesWon
        self.player = Player(name: username)
    }
    
    func updateStats(wonGame: Bool) {
        gamesPlayed += 1
        if wonGame {
            gamesWon += 1
        }
    }
}
