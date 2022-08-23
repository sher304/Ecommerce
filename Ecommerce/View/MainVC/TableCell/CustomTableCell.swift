//
//  CustomTableCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit
import Kingfisher

class CustomTableCell: UITableViewCell{
    
    static let identifier = "CustomCell"
    
    private lazy var collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        contentView.addSubview(collectionV)
        collectionV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension CustomTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTableCell.identifier, for: indexPath) as? CustomCollectionCell else { return  CustomCollectionCell()}
        cell.backgroundColor = .orange
        
//        cell.fetchData(productImage: <#T##UIImage#>, title: <#T##String#>, price: <#T##String#>, sale: <#T##String#>)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 181, height: 227)
    }
    
}
