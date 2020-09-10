//
//  Downloader.swift
//  Cocktail DB
//
//  Created by Sasha on 10/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import Foundation

class Downloader {
    
    var namePages: [String] = [] {
        didSet {
            totalPagesDownloaded = 0
            totalPagesToDownload = namePages.count
        }
    }
    
    var isDownloaded: Bool {
        return totalPagesToDownload == totalPagesDownloaded
    }
    let alamofireServise = AlamofireServise.shared
    
    var totalPagesDownloaded: Int
    var totalPagesToDownload: Int
    
    init(namePages: [String]) {
        self.namePages = namePages
        totalPagesDownloaded = 0
        totalPagesToDownload = namePages.count
    }
    
    func loadNextPage(completionHandler: @escaping ([Drink]) -> Void) {
        guard totalPagesDownloaded < totalPagesToDownload else { return }
        alamofireServise.getDrinks(namePages[totalPagesDownloaded]) { [weak self] drinks in
            completionHandler(drinks)
            self?.totalPagesDownloaded += 1
        }
    }
    
}
