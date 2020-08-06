//
//  JokeController.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/5/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation
import UIKit.UIImage

class JokeController {
    
    static func fetchJoke(category: String, completion: @escaping (Result<Joke, JokeError>) -> Void) {
        
        let baseURL = URL(string: "https://api.chucknorris.io/jokes/")
        
        guard let finalURL = baseURL?.appendingPathComponent("random?category=\(category)") else { return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let joke = topLevelDictionary.joke
                return completion(.success(joke))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }//end of function
    
    static func fetchImage(for stringURL: String, completion: @escaping (Result<UIImage, JokeError>) -> Void) {
        
        guard let url = URL(string: stringURL) else { return
            completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            completion(.success(thumbnail))
        }.resume()
    }//end of function
    
    static func fetchCategories(completion: @escaping (Result<[String], JokeError>) -> Void) {
        
        let baseURL = URL(string: "https://api.chucknorris.io/jokes/categories")
        
        URLSession.shared.dataTask(with: baseURL!) { data, _, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevel = try JSONDecoder().decode([String].self, from: data)
                var nameArray: [String] = []
                for name in topLevel {
                    print(name)
                    nameArray.append(name)
                }
                completion(.success(nameArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }//end of function
    
    
}//end of class



