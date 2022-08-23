//
//  WheelCollectionCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit
import SnapKit

class DetailWheelCollectionCell: UICollectionViewCell{
    
    static let identifier = "DetailWheelCollecitonCell"
    
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints(){
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.bottom.centerX.centerY.equalToSuperview()
            make.width.equalTo(226)
        }
    }
    
    func fetchData(link: String?){
        DispatchQueue.main.async { [self] in
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: URL(string: link ?? String()), placeholder: nil, options: nil, completionHandler: nil)
        }
    }
    
}
