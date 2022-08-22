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
    }
    
    func fetchData(image: UIImage){
        DispatchQueue.main.async { [self] in 
            productImage.image = image
        }
    }
    
}
