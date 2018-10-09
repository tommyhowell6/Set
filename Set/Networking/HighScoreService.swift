//
//  HighScoreService.swift
//  Set
//
//  Created by Tommy Howell on 10/8/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import Foundation

class HighScoreServie {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Int]?, String) -> ()
    
    var errorMessage = ""
    var tracks: [Int] = []
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getHighScoreResults(id: Int, completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "http://ec2-52-14-5-39.us-east-2.compute.amazonaws.com:8080/highScores") {
            urlComponents.query = "id=\(id)"
            
            guard let url = urlComponents.url else { return }
            print(url)
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateResults(data)
            
                    DispatchQueue.main.async {
                        completion([0,0,0], self.errorMessage)
                    }
                }
            }
            
            
            dataTask?.resume()
        }
    }
    
    fileprivate func updateResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        print(response)
        
        guard let score: Score = Score(numberOfHints: (response!["numberOfHints"] as? Int)!,
                                 numberOfMatchedSets: (response!["numberOfMatchedSets"] as? Int)!,
                                 bonusPoints: (response!["bonusPoints"] as? Int)!,
                                 wrongGuesses: (response!["wrongGuesses"] as? Int)!,
                                 user: (response!["user"] as? String)!) else {
                         errorMessage += "Unwrapping error\n"
        }
        print(score)
//        guard let array = response!["results"] as? [Any] else {
//            errorMessage += "Dictionary does not contain results key\n"
//            return
//        }
//        var index = 0
//        for trackDictionary in array {
//            if let trackDictionary = trackDictionary as? JSONDictionary,
//                let previewURLString = trackDictionary["previewUrl"] as? String,
//                let previewURL = URL(string: previewURLString),
//                let name = trackDictionary["trackName"] as? String,
//                let artist = trackDictionary["artistName"] as? String {
//                tracks.append(0)
//                index += 1
//            } else {
//                errorMessage += "Problem parsing trackDictionary\n"
//            }
//        }
    }
    
}
