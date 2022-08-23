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
        return imageV
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customOrangeTint
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCosntraints()
    }
    
    func setupCosntraints(){
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.leading.equalTo(33)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(88)
        }
        
        contentView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.top.equalToSuperview()
            make.width.equalTo(154)
        }
        
        contentView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.leading.equalTo(productImage.snp.trailing).offset(4)
            make.top.equalTo(productName.snp.bottom).offset(6)
        }
    }
    
    func fetchData(link: String, title: String, price: Int){
        DispatchQueue.main.async { [self] in
            imageView?.kf.indicatorType = .activity
            imageView?.kf.setImage(with: URL(string: link), placeholder: nil, options: nil, completionHandler: nil)
            productName.text = title
            productPrice.text = price.description
        }
    }
}
