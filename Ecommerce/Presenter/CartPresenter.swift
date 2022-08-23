//
//  CartPresenter.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation


protocol CartPresenterView{
    init(view: CartView)
    func viewDidLoad()

}

class CartPresenter: CartPresenterView{
    
    weak var view: CartView?
    
    private lazy var network: Network = {
        return Network()
    }()
    
    required init(view: CartView) {
        self.view = view
    }
    
    func viewDidLoad(){
        network.parseCart { [self] datas in
            print(datas)
            view?.fetchData(cartProducts: datas)
        }
    }
}
