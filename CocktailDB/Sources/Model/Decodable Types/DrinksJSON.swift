//
//  Coctail.swift
//  CoctailDB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import Foundation

struct DrinkJSON: Decodable {
    var idDrink: String
    var strDrink: String
    var strDrinkThumb: URL
}

struct DrinksJSON: Decodable {
  let drinks: [DrinkJSON]
}
