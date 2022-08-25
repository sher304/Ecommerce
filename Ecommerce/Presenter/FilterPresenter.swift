//
//  FilterPresenter.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 24/8/22.
//

import Foundation

protocol FilterPresenterView{
    init(view: FilterView)
    func reloadData()
}

class FilterPresenter: FilterPresenterView{
    
    private weak var view: FilterView?
    
    private lazy var network: Network = {
        return Network()
    }()
    
    required init(view: FilterView) {
        self.view = view
    }
    
    func reloadData(){
        network.parseDatas { [self] data in
            view?.fetchProducts(product: data)
        }
    }
    
}
