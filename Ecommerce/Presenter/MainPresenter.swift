//
//  MainPresenter.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit

protocol MainPresenterView: AnyObject{
    init(view: MainView)

}

class MainPresenter: MainPresenterView{
    
    private lazy var network: Network = {
        return Network()
    }()
    
    private weak var view: MainView?
    
    
    let items: [String] = ["Phones", "Computer", "Health", "Books", "Tools"]
    let images = [UIImage(systemName: "iphone")!,
                  UIImage(systemName: "desktopcomputer")!,
                  UIImage(systemName: "bolt.heart")!,
                  UIImage(systemName: "books.vertical")!,
                  UIImage(systemName: "paintbrush")!]
    
    
    func viewDidLoad(){
        network.parseDatas { [self] data in
            view?.showProducts(products: data)
        }
    }
    
    required init(view: MainView) {
        self.view = view
    }
    
}
