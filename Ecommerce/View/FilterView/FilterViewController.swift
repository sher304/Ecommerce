//
//  FilterViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 24/8/22.
//

import UIKit
import iOSDropDown
import SnapKit

protocol FilterView: AnyObject{
    func fetchProducts(product: Product)
}

class FilterViewController: UIViewController {
    
    var presenter: FilterPresenter!
    
    var products: Product! = nil
    
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = UIColor.customDarkBlue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Done
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Filter Title
    private lazy var filterTitle: UILabel = {
        let label = UILabel()
        label.text = "Filter options"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: Brand Title
    private lazy var brandTitle: UILabel = {
        let label = UILabel()
        label.text = "Brand"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: Brand Drop Down Menu Parent
    private lazy var brandDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    //MARK: Brand Drop Down Menu
    private lazy var brandDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.selectedRowColor = UIColor.customOrangeTint
        menu.textColor = .black
        menu.text = "Choose brand..."
        menu.font = UIFont(name: "Mark Pro", size: 18)
        return menu
    }()
    
    //MARK: Price Drop Down Menu Parent
    private lazy var priseDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    //MARK: Price Drop Down Menu
    private lazy var priseDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.selectedRowColor = UIColor.customOrangeTint
        menu.textColor = .black
        menu.text = "Price..."
        menu.font = UIFont(name: "Mark Pro", size: 18)
        return menu
    }()
    
    //MARK: Size Drop Down Menu Parent
    private lazy var sizeDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    //MARK: Size Drop Down Menu
    private lazy var sizeDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.selectedRowColor = UIColor.customOrangeTint
        menu.textColor = .black
        menu.text = "4.5 to 5.5 inches"
        menu.font = UIFont(name: "Mark Pro", size: 18)
        return menu
    }()
    
    //MARK: Price Title
    private lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: Size Title
    private lazy var sizeTitle: UILabel = {
        let label = UILabel()
        label.text = "Size"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.reloadData()
        setupConstraints()
    }
    
    //MARK: DropDownMenu Options
    func setDropDown(){
        brandDropDownMenu.didSelect { selectedText, index, id in
            self.brandDropDownMenu.text = selectedText
        }
    }
    
    //MARK: Set Up constraints
    func setupConstraints(){
        setDropDown()
        view.addSubview(contentView)
        contentView.backgroundColor = .customBackgroundWhite
        contentView.snp.makeConstraints { make in
            make.height.equalTo(425)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(24)
            make.width.height.equalTo(37)
        }
        
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(24)
            make.height.equalTo(37)
            make.width.equalTo(86)
        }
        
        contentView.addSubview(filterTitle)
        filterTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(doneButton)
        }
        
        contentView.addSubview(brandTitle)
        brandTitle.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.top.equalTo(dismissButton.snp.bottom).offset(24)
        }
        
        contentView.addSubview(brandDropDownParent)
        brandDropDownParent.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.trailing.equalTo(-31)
            make.height.equalTo(37)
            make.top.equalTo(brandTitle.snp.bottom).offset(20)
        }
        
        brandDropDownParent.addSubview(brandDropDownMenu)
        brandDropDownMenu.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(-20)
            make.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(priceTitle)
        priceTitle.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.top.equalTo(brandDropDownParent.snp.bottom).offset(15)
        }
        
        contentView.addSubview(priseDropDownParent)
        priseDropDownParent.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.trailing.equalTo(-31)
            make.height.equalTo(37)
            make.top.equalTo(priceTitle.snp.bottom).offset(20)
        }
        
        priseDropDownParent.addSubview(priseDropDownMenu)
        priseDropDownMenu.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(-20)
            make.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(sizeTitle)
        sizeTitle.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.top.equalTo(priseDropDownParent.snp.bottom).offset(15)
        }
        
        contentView.addSubview(sizeDropDownParent)
        sizeDropDownParent.snp.makeConstraints { make in
            make.leading.equalTo(46)
            make.trailing.equalTo(-31)
            make.height.equalTo(37)
            make.top.equalTo(sizeTitle.snp.bottom).offset(20)
        }
        
        sizeDropDownParent.addSubview(sizeDropDownMenu)
        sizeDropDownMenu.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(-20)
            make.top.bottom.equalToSuperview()
        }
    }
    
    //MARK: Set Data to VC
    func setData(){
        DispatchQueue.main.async {
            let items = self.products.bestSeller
            var brands: [String] = []
            var prices: [String] = []
            for item in items {
                brands.append(item.title)
                prices.append("$\(item.priceWithoutDiscount)")
            }
            self.brandDropDownMenu.optionArray = brands
            self.priseDropDownMenu.optionArray = prices
        }
    }
    
    //MARK: Close VC Tapped
    @objc func tabButtonTapped(btn: UIButton){
        if btn == dismissButton{
            dismiss(animated: true)
        }else{
            dismiss(animated: true)
        }
    }
}

//MARK: Extention of VC Presenter
extension FilterViewController: FilterView{
    func fetchProducts(product: Product) {
        self.products = product
        setData()
    }
}
