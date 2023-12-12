//
//  NetworkingManager.swift
//  Harmony
//
//  Created by Nikhil kumar  on 12/1/23.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}

    
    
    // Access ZenQuotes API and fetch Qutoes 
    func fetchQuotes(completion: @escaping ([Quote]?, Error?) -> Void) {
        let urlString = "https://zenquotes.io/api/random/"

        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 1, userInfo: nil))
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                
                completion(quotes, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
