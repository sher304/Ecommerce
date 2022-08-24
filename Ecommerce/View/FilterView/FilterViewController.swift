//
//  FilterViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 24/8/22.
//

import UIKit
import iOSDropDown
import SnapKit

class FilterViewController: UIViewController {
    
    
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
        
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    private lazy var filterTitle: UILabel = {
        let label = UILabel()
        label.text = "Filter options"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    private lazy var brandTitle: UILabel = {
        let label = UILabel()
        label.text = "Brand"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    private lazy var brandDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    private lazy var barndDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.textColor = .black
        return menu
    }()
    
    private lazy var priseDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    private lazy var priseDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.textColor = .black
        return menu
    }()
    
    private lazy var sizeDropDownParent: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    private lazy var sizeDropDownMenu: DropDown = {
        let menu = DropDown()
        menu.rowBackgroundColor = UIColor.customBackgroundWhite
        menu.arrowColor = UIColor.customGray
        menu.textColor = .black
        return menu
    }()
    
    private lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    private lazy var sizeTitle: UILabel = {
        let label = UILabel()
        label.text = "Size"
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    func setDropDown(){
        barndDropDownMenu.optionArray = ["Option 1", "Option 2", "Option 3"]
        barndDropDownMenu.optionIds = [1,23,54,22]
        barndDropDownMenu.didSelect { selectedText, index, id in
            self.barndDropDownMenu.text = selectedText
        }
    }
    
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
        
        brandDropDownParent.addSubview(barndDropDownMenu)
        barndDropDownMenu.snp.makeConstraints { make in
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
}
