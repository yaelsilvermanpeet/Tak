//
//  GameAPI.swift
//  Tak
//
//  Created by Yael Peet on 5/2/23.
//

import Foundation

class GameAPI {
    let apiClient: APIClient
    let baseURL = URL(string: "https://your-backend-service.com")!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func startNewGame(completion: @escaping (Result<Game, Error>) -> Void) {
        let startNewGameURL = baseURL.appendingPathComponent("/start-new-game")
        var request = URLRequest(url: startNewGameURL)
        request.httpMethod = "POST"
        
        apiClient.performRequest(with: request, completion: completion)
    }
    
    func getGame(gameId: String, completion: @escaping (Result<Game, Error>) -> Void) {
        let getGameURL = baseURL.appendingPathComponent("/games/\(gameId)")
        let request = URLRequest(url: getGameURL)
        
        apiClient.performRequest(with: request, completion: completion)
    }
}
