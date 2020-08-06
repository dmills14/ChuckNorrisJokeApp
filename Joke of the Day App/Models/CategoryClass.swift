//
//  CategoryClass.swift
//  Joke of the Day App
//
//  Created by Drew Miller on 8/5/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation

class Category: Decodable {
    
    let name: String
}

struct CategoryTopLevel: Decodable {
    
    var categories: [Category]
}
