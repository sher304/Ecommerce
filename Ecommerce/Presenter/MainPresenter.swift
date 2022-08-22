//
//  MainPresenter.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation

protocol MainPresenterView: AnyObject{
    init(view: MainView)
    func viewDidLoad()
}

class MainPresenter: MainPresenterView{
    
    private lazy var network: Network = {
        return Network()
    }()
    
    private weak var view: MainView?
    
    var products: [Product] = []
    
    func viewDidLoad(){
        network.parseDatas { [self] data in
            products = [data]
            view?.reloadData()
        }
    }
    
    required init(view: MainView) {
        self.view = view
    }
    
}
