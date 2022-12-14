//
//  CollectionCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit
import SnapKit

class CollecitonCell: UICollectionViewCell{
    
    //MARK: Identofier of Collection Cell
    static let identifier = "CustomCell"
    
    //MARK: Background View
    private lazy var backgroundV: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 71 / 2
        return view
    }()
    
    //MARK: Icon of Product
    private lazy var iconImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "iphone")
        imageV.tintColor = UIColor(red: 179/255, green: 179/255, blue: 199/255, alpha: 1)
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    //MARK: Category of Product
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = "Computer"
        label.font = UIFont(name: "Mark Pro", size: 12)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    //MARK: Set constraints
    private func setConstraints(){
        contentView.addSubview(backgroundV)
        backgroundV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-5)
            make.width.height.equalTo(71)
        }
        
        backgroundV.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(35)
        }
        contentView.addSubview(categoryTitle)
        categoryTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundV.snp.bottom)
        }
    }
    
    //MARK: Fetch Data, and Set To Screen
    func fetchData(icon: UIImage, title: String){
        DispatchQueue.main.async { [self] in
            iconImage.image = icon
            categoryTitle.text = title
        }
    }
    
    //MARK: Did selected Function
    func didSelected(indx: Int){
        iconImage.tintColor = .white
        backgroundV.backgroundColor = UIColor.customOrangeTint
        categoryTitle.textColor = UIColor.customOrangeTint
        
    }
    
    //MARK: Did Deselected Function
    func didDeselect(indx: Int){
        backgroundV.backgroundColor = .white
        iconImage.tintColor = UIColor(red: 179/255, green: 179/255, blue: 199/255, alpha: 1)
        categoryTitle.textColor = UIColor.customDarkBlue
    }
}
