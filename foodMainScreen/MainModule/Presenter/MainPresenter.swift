//
//  MainPresenter.swift
//  test1
//
//  Created by Артем Макар on 9.04.23.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: APIManagerProtocol)
    func getData()
    var data: [Product]? { get set}
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: APIManagerProtocol?
    var data: [Product]?
    
    required init(view: MainViewProtocol, networkService: APIManagerProtocol) {
        self.view = view
        self.networkService = networkService
        getData()
    }
    
    func getData() {
        networkService?.getProducts(products: ProductList.products, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return}
                self.data = result.sorted(by: { product1, product2 in
                    Int(product1.numberID!)! < Int(product2.numberID!)!
                })
                print(result)
                self.view?.succes()
            }
        })
        view?.succes()
    }
}
