//
//  CatImage.swift
//  Cats
//
//  Created by Inna Litvinenko on 5/4/20.
//  Copyright © 2020 Inna Litvinenko. All rights reserved.
//

import Foundation

class CatImage : Decodable {
   
    var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case url
       }
       
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
