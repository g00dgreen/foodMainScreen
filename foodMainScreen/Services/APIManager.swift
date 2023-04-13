//
//  APICaller.swift
//  test1
//
//  Created by Артем Макар on 6.04.23.
//

import Foundation

protocol APIManagerProtocol {
    func getProducts(products: [String], completion: @escaping ([Product]) -> Void)
}

class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    func getProducts(products: [String], completion: @escaping ([Product]) -> Void) {
        var productsArr: [Product] = []
        for (number, product) in products.enumerated() {
            let urlString = "https://api.spoonacular.com/food/products/search?apiKey=\(APISettings.keyAPI)&query=\(product)&addProductInformation=true&number=\(APISettings.numberOfCategories)&offset=3"
            print(urlString)
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    return }
                if let productsData = try? JSONDecoder().decode(Products.self, from: data) {
                    print("success \(product)")
                    productsData.products.forEach({ value in
                        var product = value
                        product.numberID = "\(number)"
                        productsArr.append(product)
                    })
                    if productsArr.count == APISettings.numberOfCategories * 6 {
                        completion(productsArr)
                    } else {
                        print(productsArr.count, "!=", APISettings.numberOfCategories * 6)
                    }
                } else {
                    print("request fail")
                }
            }
            task.resume()
        }
    }
        
}






