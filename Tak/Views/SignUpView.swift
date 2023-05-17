//
//  SignUpView.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI
struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
            
            TextField("Username", text: $username)
                .padding()
                .border(Color.gray, width: 0.5)
            
            TextField("Email", text: $email)
                .padding()
                .border(Color.gray, width: 0.5)
            
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray, width: 0.5)
            
            Button(action: {
                userViewModel.signUp(username: username, email: email, password: password)
            }) {
                Text("Sign Up")
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
