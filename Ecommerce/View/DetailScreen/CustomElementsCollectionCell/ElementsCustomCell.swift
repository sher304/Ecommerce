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
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
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
    
    func didSelected(){
        elementTitle.textColor = UIColor.customDarkBlue
        elementTitle.font = UIFont(name: "Mark Pro Medium", size: 20)
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: elementTitle.text!, attributes: underlineAttribute)
        elementTitle.attributedText = underlineAttributedString

    }
    
    func cancelSelected(){
        elementTitle.font = UIFont(name: "Mark Pro", size: 20)
        elementTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let underlineAttributedString = NSAttributedString(string: elementTitle.text!, attributes: .none)
        elementTitle.attributedText = underlineAttributedString

    }
}
