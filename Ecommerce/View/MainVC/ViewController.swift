//
//  ViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import UIKit

protocol MainView: AnyObject{
    func reloadData()
    
}

class MainViewController: UIViewController {

    var presenter: MainPresenterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MainViewController: MainView{
    func reloadData(){
        
    }
}
