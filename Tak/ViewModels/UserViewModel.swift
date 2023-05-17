//
//  UserViewModel.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    private var userService: UserService // Assume you have a UserService to handle sign in and sign up
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func signIn(username: String, password: String) {
        userService.signIn(username: username, password: password) { result in
            switch result {
            case .success(let userProfile):
                self.userProfile = userProfile
            case .failure(let error):
                print("Sign in failed with error: \(error)")
            }
        }
    }
    
    func signUp(username: String, email: String, password: String) {
        userService.signUp(username: username, email: email, password: password) { result in
            switch result {
            case .success(let userProfile):
                self.userProfile = userProfile
            case .failure(let error):
                print("Sign up failed with error: \(error)")
            }
        }
    }
}
