//
//  MovieController.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/22/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

struct MovieController {
    static var shared = MovieController()
    
    var favorites: [SearchItem] = []
    var favoriteImages: [UIImage] = []
}
