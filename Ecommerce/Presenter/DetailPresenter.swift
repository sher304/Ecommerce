//
//  DetailPresenter.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation

protocol DetailPresenterView: AnyObject{
    init(view: DetailView)
    func viewDidLoad()
    
}

class DetailPresenter: DetailPresenterView{
    
    weak var view: DetailView?
    
    private lazy var network: Network = {
        return Network()
    }()
    
    required init(view: DetailView) {
        self.view = view
    }
    
    func viewDidLoad() {
        network.parseSingleElement { [self] data in
            view?.fetchData(productDetail: data)
        }
    }
    
}
