//
//  JokeError.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/5/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation

enum JokeError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The serve failed to reach the URL.  Check your URL, Boss."
        case .thrownError(let error):
            return "There was an error \(error.localizedDescription)"
        case .noData:
            return "Data failed to load"
        case .unableToDecode:
            return "There was an error when loading the data."
        }
    }
    
}
