//
//  Joke.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/5/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation

class Joke: Decodable {
    
    let icon_url: String
    let value: String
}

struct TopLevelObject: Decodable {
    
    var joke: Joke
}
