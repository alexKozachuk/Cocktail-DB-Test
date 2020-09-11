//
//  AlamofireServise.swift
//  Cocktail DB
//
//  Created by Sasha on 10/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireServise {
    static var shared: AlamofireServise { return AlamofireServise()}
    var baseStringURL = "https://www.thecocktaildb.com/api/json/v1/1"
    private init() {}
    
    func getListCategory(completionHandler: @escaping ([Filter]) -> Void) {
        let request = AF.request(baseStringURL + "/list.php?c=list")
        let queue = DispatchQueue(label: "com.Alexandr.CocktailDB", qos: .background, attributes: .concurrent)
        
        request.responseDecodable(of: FiltersJSON.self, queue: queue) { response in
            guard let filtersJSON = response.value else { return }
            let filters = filtersJSON.drinks.map { Filter(name: $0.strCategory) }
            completionHandler(filters)
        }
    }
    
    func getDrinks(_ category: String, completionHandler: @escaping ([Drink]) -> Void) {
        let formatedCategory = category.replacingOccurrences(of: " ", with: "_")
        let request = AF.request(baseStringURL + "/filter.php?c=" + formatedCategory)
        let queue = DispatchQueue(label: "com.Alexandr.CocktailDB", qos: .background, attributes: .concurrent)
        request.responseDecodable(of: DrinksJSON.self, queue: queue) { response in
            guard let cocktails = response.value else { return }
            var drinks: [Drink] = []
            for cocktail in cocktails.drinks {
                let drink = Drink(name: cocktail.strDrink, url: cocktail.strDrinkThumb)
                drinks.append(drink)
            }
            completionHandler(drinks)
        }
    }
    
    func getImage(_ url: URL, completionHandler: @escaping (UIImage) -> Void){
        let queue = DispatchQueue(label: "com.Alexandr.CocktailDB", qos: .background, attributes: .concurrent)
        var photoUrl = url
        photoUrl.appendPathComponent("preview", isDirectory: false)
        queue.async {
            guard let photoData = try? Data(contentsOf: photoUrl) else { return }
            guard let photoImage = UIImage(data: photoData) else { return }
            completionHandler(photoImage)
        }
        
        
    }
    
    
}
