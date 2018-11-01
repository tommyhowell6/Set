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
    typealias QueryResult = ([ScoreHolder]?, String) -> ()
    
    var errorMessage = ""
    var highScores: [ScoreHolder] = []
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    let addressForGet = "http://localhost:8080/set/scores"
    let addressForPost = "http://localhost:8080/set/scores"
    //            ec2-52-14-5-39.us-east-2.compute.amazonaws.com:8080

    
    func getHighScoreResults(completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: addressForGet) {
//            urlComponents.query = "id=\(id)" not setup for this now, use "/\(id)" in the path name
            
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
                        completion(self.highScores, self.errorMessage)
                    }
                }
            }
            
            
            dataTask?.resume()
        }
    }
    
    fileprivate func updateResults(_ data: Data) {
        do {
            let scores = try JSONDecoder().decode([ScoreHolder].self, from: data)
            highScores = scores
            print(scores)
        } catch let jsonErr {
            print (jsonErr)
        }
    }
    
    func postHighScore(score: Score) {
        submitPost(post: score) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // We'll need a completion block that returns an error if we run into any problems
    func submitPost(post: Score, completion:((Error?) -> Void)?) {
        if let urlComponents = URLComponents(string: addressForPost)
        {
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "jsonplaceholder.typicode.com"
    //        urlComponents.path = "/posts"
            guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
            
            // Specify this request as being a POST method
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // Make sure that we include headers specifying that our request's HTTP body
            // will be JSON encoded
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            
            // Now let's encode out Post struct into JSON data...
            let encoder = JSONEncoder()
            do {
                let jsonData = try encoder.encode(post)
                // ... and set our request's HTTP body
                request.httpBody = jsonData
                print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
            } catch {
                completion?(error)
            }
            
            // Create and run a URLSession data task with our JSON encoded POST request
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else {
                    completion?(responseError!)
                    return
                }
                
                // APIs usually respond with the data you just sent in your POST request
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    print("response: ", utf8Representation)
                } else {
                    print("no readable data received in response")
                }
            }
            task.resume()
        }
    }
    
}
