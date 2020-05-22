//
//  ModelController.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/5/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import Foundation

class ModelController {
    var catBreeds = [Breed]()
    var fetcher = UrlSession()
    var breedIndex: [String: Int] = [:]
}
