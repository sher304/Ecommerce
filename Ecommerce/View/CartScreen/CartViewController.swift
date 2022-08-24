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
    
    var cartProducts: CartProduct? = nil
    
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height + CGFloat(cartProducts?.basket.count ?? 0 * 120) + 100)
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.contentSize = contentSize
        scrollV.frame = view.bounds
        scrollV.backgroundColor = UIColor.customBackgroundWhite
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    private lazy var mainContentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = UIColor.customBackgroundWhite
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = UIColor.customDarkBlue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTappet), for: .touchUpInside)
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
        table.backgroundColor = contentView.backgroundColor
        table.separatorStyle = .none
        return table
    }()
    
    
    private lazy var upLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.25)
        return view
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro", size: 15)
        return label
    }()
    
    private lazy var totalInfromLabel: UILabel = {
        let label = UILabel()
        label.text = "$6,000 us"
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro Bold", size: 15)
        return label
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery"
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro", size: 15)
        return label
    }()
    
    private lazy var deliveryInfromLabel: UILabel = {
        let label = UILabel()
        label.text = "Free"
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro Bold", size: 15)
        return label
    }()
    
    private lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.25)
        return view
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 20)
        button.setTitle("Checkout", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView(){
        view.backgroundColor = UIColor.customBackgroundWhite
        view.addSubview(scrollView)
        scrollView.addSubview(mainContentView)
        setpuConstraints()
        setupNavBar()
    }
    
    func setpuConstraints(){
        mainContentView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        mainContentView.addSubview(mapButton)
        mapButton.snp.makeConstraints { make in
            make.trailing.equalTo(-46)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        mainContentView.addSubview(addAddressTitle)
        addAddressTitle.snp.makeConstraints { make in
            make.trailing.equalTo(mapButton.snp.leading).offset(-9)
            make.centerY.equalTo(mapButton)
        }
        
        mainContentView.addSubview(mayCartTitle)
        mayCartTitle.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(backButton.snp.bottom).offset(50)
        }
        
        mainContentView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(mayCartTitle.snp.bottom).offset(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-230)
            make.top.equalTo(90)
        }
        
        contentView.addSubview(upLine)
        upLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(productsTableView.snp.bottom)
        }
        
        contentView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.leading.equalTo(55)
            make.top.equalTo(upLine.snp.bottom).offset(15)
        }
        
        contentView.addSubview(totalInfromLabel)
        totalInfromLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalLabel)
            make.trailing.equalTo(-35)
        }
        
        contentView.addSubview(deliveryLabel)
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(12)
            make.leading.equalTo(55)
        }
        
        contentView.addSubview(deliveryInfromLabel)
        deliveryInfromLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryLabel)
            make.leading.equalTo(totalInfromLabel.snp.leading)
        }
        
        contentView.addSubview(underLine)
        underLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(deliveryLabel.snp.bottom).offset(26)
            make.height.equalTo(1)
        }
        
        contentView.addSubview(checkoutButton)
        checkoutButton.snp.makeConstraints { make in
            make.leading.equalTo(44)
            make.trailing.equalTo(-44)
            make.height.height.equalTo(54)
            make.top.equalTo(underLine.snp.bottom).offset(27)
        }
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    
        navigationController?.navigationBar.tintColor = UIColor.customBackgroundWhite
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc func backButtonTappet(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartScreenTapp(){
        
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts?.basket.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartTableCell()
        guard let items = cartProducts?.basket[indexPath.row] else { return CartTableCell()}
        cell.fetchData(link: items.images, title: items.title, price: items.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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

extension CartViewController: UIScrollViewDelegate{
    //MARK: Scroll Down, Hide Navbar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            //scrolling down
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        //MARK: Scroll Up, Show Navbar
        else{
            //scrolling up
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
