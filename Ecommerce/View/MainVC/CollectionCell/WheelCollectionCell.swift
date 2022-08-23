//
//  WheelCollectionCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit
import SnapKit

class WheelCollectionCell: UICollectionViewCell {
    
    static let identifier = "CustomCell"
    
    private lazy var productImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "person.fill")
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.text = "Iphone 12"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = .white
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now!", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 11)
        button.setTitleColor(UIColor(red: 1/255, green: 0/255, blue: 53/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private lazy var isNewParent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
        view.layer.cornerRadius = 27 / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var isNewlabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.font = UIFont(name: "Mark Pro Bold", size: 10)
        return label
    }()
    
    private lazy var shortDescription: UILabel = {
        let label = UILabel()
        label.text = "Súper. Mega. Rápido."
        label.font = UIFont(name: "Mark Pro", size: 11)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    private func setupUI(){
        contentView.addSubview(productImage)
        contentView.backgroundColor = .orange
        productImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImage.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(30)
        }
        
        productImage.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(98)
            make.height.equalTo(23)
            make.leading.equalTo(30)
            make.bottom.equalTo(-30)
        }
        
        productImage.addSubview(isNewParent)
        isNewParent.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.top.equalTo(15)
            make.width.height.equalTo(27)
        }
        
        isNewParent.addSubview(isNewlabel)
        isNewlabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        productImage.addSubview(shortDescription)
        shortDescription.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.top.equalTo(productName.snp.bottom).offset(5)
        }
    }
    
    func fetchData(image: String){
        DispatchQueue.main.async { [self] in
            productImage.kf.indicatorType = .activity
            productImage.kf.setImage(with: URL(string: image.description), placeholder: nil, options: nil, completionHandler: nil)
        }
    }
    
}
