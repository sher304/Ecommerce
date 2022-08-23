//
//  ElementsCustomCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit
import SnapKit

class ElementsCustomCell: UICollectionViewCell {
    
    static let indentifier = "CustomElementsCell"
    
    private lazy var elementTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 20)
        label.textColor = UIColor.customDarkBlue
        label.text = "Sow"
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints(){
        contentView.addSubview(elementTitle)
        elementTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchData(title: String){
        DispatchQueue.main.async { [self] in
            elementTitle.text = title
        }
    }
}
