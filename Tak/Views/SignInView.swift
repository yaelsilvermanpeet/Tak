//
//  SignInView.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("Sign In")
                .font(.largeTitle)
            
            TextField("Username", text: $username)
                .padding()
                .border(Color.gray, width: 0.5)
            
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray, width: 0.5)
            
            Button(action: {
                userViewModel.signIn(username: username, password: password)
            }) {
                Text("Sign In")
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
