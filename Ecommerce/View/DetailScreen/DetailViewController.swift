//
//  DetailViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import UIKit

protocol DetailView: AnyObject{
    
}

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    func setupConstraints(){
        
    }
}
