//
//  Filter.swift
//  CoctailDB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import Foundation

struct FilerJSON: Decodable {
    var strCategory: String
}

struct FiltersJSON: Decodable {
    var drinks: [FilerJSON]
}
