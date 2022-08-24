//
//  CartTableCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit


class CartTableCell: UITableViewCell{
    
    static let identifier = "CustomTableCell"
    
    private lazy var productImage: UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 10
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro Medium", size: 20)
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customOrangeTint
        label.font = UIFont(name: "Mark Pro Medium", size: 20)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCosntraints()
    }
    
    private lazy var buttonsParentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 67/255, alpha: 1)
        view.layer.cornerRadius = 13
        return view
    }()
    
    private lazy var subtractButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = UIFont(name: "Mark Pro", size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = UIColor(red: 54/255, green: 54/255, blue: 77/255, alpha: 1)
        return button
    }()
    
    func setupView(){
        contentView.backgroundColor = UIColor.customDarkBlue
    }
    
    func setupCosntraints(){
        setupView()
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.leading.equalTo(33)
            make.width.height.equalTo(88)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.top.equalTo(productImage.snp.top)
            make.trailing.equalTo(-123)
        }
        
        contentView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.top.equalTo(productName.snp.bottom).offset(6)
        }
        
        contentView.addSubview(buttonsParentView)
        buttonsParentView.snp.makeConstraints { make in
            make.height.equalTo(68)
            make.width.equalTo(26)
            make.centerY.equalToSuperview()
            make.leading.equalTo(productName.snp.trailing).offset(33)
        }
        
        buttonsParentView.addSubview(subtractButton)
        subtractButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(5)
            make.width.equalTo(9.36)
        }
        
        buttonsParentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        buttonsParentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-5)
            make.width.equalTo(8.36)
            make.height.equalTo(9)
        }
        
        contentView.addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.trailing.equalTo(-32.25)
            make.width.equalTo(14.75)
            make.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func fetchData(link: String, title: String, price: Int){
        DispatchQueue.main.async { [self] in
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: URL(string: link), placeholder: nil, options: nil, completionHandler: nil)
            productName.text = title
            productPrice.text = "$\(price)"
        }
    }
}
