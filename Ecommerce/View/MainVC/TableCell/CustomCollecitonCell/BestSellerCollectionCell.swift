//
//  CustomCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class BestSellerCollectionCell: UICollectionViewCell{
    
    static let identifier = "CustomCell"
    
    private lazy var parentBg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var proudctImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "person.fill")
        imageV.backgroundColor = .red
        return imageV
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.text = "$1,047"
        label.font = UIFont(name: "Mark Pro Bold", size: 16)
        label.textColor = UIColor(red: 1/255, green: 0, blue: 52/255, alpha: 1)
        return label
    }()
    
    private lazy var productSale: UILabel = {
        let label = UILabel()
        label.text = "$1,500"
        label.font = UIFont(name: "Mark Pro", size: 10)
        label.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        label.strikeThroughText()
        return label
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.text =  "Samsung Galaxy s20 Ultra"
        label.textColor = UIColor(red: 1/255, green: 0, blue: 52/255, alpha: 1)
        label.font = UIFont(name: "Mark Pro", size: 10)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
        button.layer.cornerRadius = 25 / 2
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTappetFavButton), for: .touchUpInside)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        
    }
    
    func setupConstraints(){
        contentView.addSubview(parentBg)
        parentBg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        parentBg.addSubview(proudctImage)
        proudctImage.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-55)
        }
        
        parentBg.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.leading.equalTo(21)
            make.top.equalTo(proudctImage.snp.bottom).offset(2)
        }
        
        parentBg.addSubview(productSale)
        productSale.snp.makeConstraints { make in
            make.leading.equalTo(productPrice.snp.trailing).offset(7)
            make.top.equalTo(proudctImage.snp.bottom).offset(8)
        }
        
        parentBg.addSubview(productTitle)
        productTitle.snp.makeConstraints { make in
            make.leading.equalTo(21)
            make.top.equalTo(productSale.snp.bottom).offset(6)
        }
        
        parentBg.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.top.equalTo(10)
            make.width.height.equalTo(25)
        }
    }
    
    func fetchData(productImage: String, title: String, price: String, sale: String){
        DispatchQueue.main.async {
            self.proudctImage.kf.indicatorType = .activity
            self.proudctImage.kf.setImage(with: URL(string: productImage), placeholder: nil, options: nil, completionHandler: nil)
            self.productTitle.text = title.description
            self.productPrice.text = "$\(price)"
            self.productSale.text = sale
        }
    }
    
    var validator = true
    @objc func didTappetFavButton(){
        if validator{
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            validator = false
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            validator = true
        }
        
    }
}


extension UILabel {
  func strikeThroughText() {
    let attributeString =  NSMutableAttributedString(string: self.text ?? "")
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
    self.attributedText = attributeString
  }
}
