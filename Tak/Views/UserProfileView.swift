//
//  UserProfileView.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userProfile: UserProfile
    
    var body: some View {
        VStack {
            Text("Username: \(userProfile.username)")
                .font(.title)
            
            Text("Email: \(userProfile.email)")
                .font(.title2)
            
            Text("Games Played: \(userProfile.gamesPlayed)")
                .font(.title2)
            
            Text("Games Won: \(userProfile.gamesWon)")
                .font(.title2)
            
            Button(action: {
                // Action to start a new game
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
