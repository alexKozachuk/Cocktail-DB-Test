//
//  AlamofireServise.swift
//  CoctailDB
//
//  Created by Sasha on 10/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireServise {
    static var shared: AlamofireServise { return AlamofireServise()}
    var baseStringURL = "https://www.thecocktaildb.com/api/json/v1/1"
    private init() {}
    
    func getListCategory(completionHandler: @escaping ([Filter]) -> Void) {
        let request = AF.request(baseStringURL + "/list.php?c=list")
        request.responseDecodable(of: FiltersJSON.self) { response in
            guard let filtersJSON = response.value else { return }
            let filters = filtersJSON.drinks.map { Filter(name: $0.strCategory) }
            completionHandler(filters)
        }
    }
    
    func getDrinks(_ category: String, completionHandler: @escaping ([Drink]) -> Void) {
        let formatedCategory = category.replacingOccurrences(of: " ", with: "_")
        let request = AF.request(baseStringURL + "/filter.php?c=" + formatedCategory)
        let queue = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)
        request.responseDecodable(of: DrinksJSON.self, queue: queue) { response in
            //print(response)
            guard let coctails = response.value else { return }
            var drinks: [Drink] = []
            
            for coctail in coctails.drinks {
                var photoUrl = coctail.strDrinkThumb
                photoUrl.appendPathComponent("preview", isDirectory: false)
                //print(photoUrl)
                guard let photoData = try? Data(contentsOf: photoUrl) else { return }
                guard let photoImage = UIImage(data: photoData) else { return }
                let drink = Drink(name: coctail.strDrink, image: photoImage)
                drinks.append(drink)
            }
            completionHandler(drinks)
        }
    }
    
    
}
