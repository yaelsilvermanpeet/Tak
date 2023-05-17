//
//  UserAPI.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation

class UserAPI {
    let apiClient: APIClient
    let baseURL = URL(string: "https://your-backend-service.com")!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func signIn(username: String, password: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let signInURL = baseURL.appendingPathComponent("/sign-in")
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        apiClient.performRequest(with: request, completion: completion)
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let signUpURL = baseURL.appendingPathComponent("/sign-up")
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        let body = ["username": username, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        apiClient.performRequest(with: request, completion: completion)
    }
}
