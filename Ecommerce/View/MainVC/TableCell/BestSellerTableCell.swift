//
//  CustomTableCell.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit
import Kingfisher

class BestSellerTableCell: UITableViewCell{
    
    //MARK: Identifier of Table Cell
    static let identifier = "CustomCell"
    
    //MARK: ProducstData
    var products: Product? = nil
    
    var delegate: BestSellerDelegate? = nil
    
    //MARK: Collection View
    private lazy var collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(BestSellerCollectionCell.self, forCellWithReuseIdentifier: BestSellerCollectionCell.identifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = UIColor.customBackgroundWhite
        return collectionV
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: Setup Constraints
    private func setupConstraints(){
        contentView.addSubview(collectionV)
        collectionV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: Fetch Data and Set to Products Data
    func fetchProducts(products: Product, delegate: BestSellerDelegate){
        self.products = products
        self.delegate = delegate
        collectionV.reloadData()
    }
}

//MARK: Extenstion of Collection View
extension BestSellerTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.bestSeller.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCollectionCell.identifier, for: indexPath) as? BestSellerCollectionCell else { return  BestSellerCollectionCell()}
        guard let items = products?.bestSeller[indexPath.row] else { return BestSellerCollectionCell()}
        cell.fetchData(productImage: items.picture, title: items.title.description, price: items.priceWithoutDiscount.description, sale: items.discountPrice.description)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 181, height: 227)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected()
    }
}

protocol BestSellerDelegate{
    func didSelected()
}
