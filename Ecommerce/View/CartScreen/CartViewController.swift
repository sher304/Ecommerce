//
//  CartViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import UIKit
import SnapKit

protocol CartView: AnyObject{
    func fetchData(cartProducts: CartProduct)
}

class CartViewController: UIViewController {

    var presenter: CartPresenter!
    
    var cartProducts: CartProduct! = nil
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = UIColor.customDarkBlue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        return button
    }()
    
    private lazy var addAddressTitle: UILabel = {
        let label = UILabel()
        label.text = "Add address"
        label.font = UIFont(name: "Mark Pro Medium", size: 15)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mappin"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var mayCartTitle: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.textColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Mark Pro Bold", size: 35)
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customDarkBlue
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var productsTableView: UITableView = {
        let table = UITableView()
        table.register(CartTableCell.self, forCellReuseIdentifier: CartTableCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setpuConstraints()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.customBackgroundWhite
    }
    
    func setpuConstraints(){
        setupView()
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        view.addSubview(mapButton)
        mapButton.snp.makeConstraints { make in
            make.trailing.equalTo(-46)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        view.addSubview(addAddressTitle)
        addAddressTitle.snp.makeConstraints { make in
            make.trailing.equalTo(mapButton.snp.leading).offset(-9)
            make.centerY.equalTo(mapButton)
        }
        
        view.addSubview(mayCartTitle)
        mayCartTitle.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(backButton.snp.bottom).offset(50)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(mayCartTitle.snp.bottom).offset(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-150)
            make.top.equalTo(90)
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartTableCell()
        let items = cartProducts.basket[indexPath.row]
        cell.fetchData(link: items.images, title: items.title, price: items.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CartViewController: CartView{
    func fetchData(cartProducts: CartProduct) {
        DispatchQueue.main.async {
            self.cartProducts = cartProducts
            self.productsTableView.reloadData()
        }
    }
}
