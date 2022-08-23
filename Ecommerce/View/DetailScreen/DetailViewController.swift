//
//  DetailViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import UIKit
import SnapKit

protocol DetailView: AnyObject{
    func fetchData(productDetail: ProductDetail)
}

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterView?
    
    var productDetail: ProductDetail? = nil
    
    private lazy var titleSceen: UILabel = {
        let label = UILabel()
        label.text = "Product Details"
        label.textColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Mark Pro Medium", size: 18)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = UIColor.customDarkBlue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bag"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var wheelProductCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(DetailWheelCollectionCell.self, forCellWithReuseIdentifier: DetailWheelCollectionCell.identifier)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.layer.cornerRadius = 25
        collectionV.layer.masksToBounds = true
        collectionV.backgroundColor = view.backgroundColor
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.text = "Galaxy Note 20 Ultra"
        label.textColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Mark Pro Medium", size: 24)
        return label
    }()
    
    private lazy var favButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customDarkBlue
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var informParentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var firstStar: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "star.fill")
        imageV.tintColor = UIColor.customYellowTint
        return imageV
    }()
    
    private lazy var secondStar: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "star.fill")
        imageV.tintColor = UIColor.customYellowTint
        return imageV
    }()
    
    private lazy var thirdStar: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "star.fill")
        imageV.tintColor = UIColor.customYellowTint
        return imageV
    }()
    
    private lazy var fourthStar: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "star.fill")
        imageV.tintColor = UIColor.customYellowTint
        return imageV
    }()
    
    private lazy var fifthStar: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "star.fill")
        imageV.tintColor = UIColor.customYellowTint
        return imageV
    }()
    
    private lazy var hideStar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var shopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Shop", for: .normal)
        button.setTitleColor(UIColor.customDarkBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 20)
        return button
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro", size: 20)
        return button
    }()
    
    private lazy var featuresButton: UIButton = {
        let button = UIButton()
        button.setTitle("Features", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro", size: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupConstraints()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.customBackgroundWhite
    }
    
    func setupConstraints(){
        setupView()
        
        view.addSubview(titleSceen)
        titleSceen.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(86)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        view.addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.trailing.equalTo(-35)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        view.addSubview(wheelProductCollection)
        wheelProductCollection.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(350)
            make.top.equalTo(titleSceen.snp.bottom).offset(37)
        }
        
        view.addSubview(informParentView)
        informParentView.snp.makeConstraints { make in
            make.top.equalTo(wheelProductCollection.snp.bottom).offset(7)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        informParentView.addSubview(productTitle)
        productTitle.snp.makeConstraints { make in
            make.leading.equalTo(38)
            make.top.equalTo(28)
        }
        
        informParentView.addSubview(favButton)
        favButton.snp.makeConstraints { make in
            make.trailing.equalTo(-37)
            make.centerY.equalTo(productTitle)
            make.height.equalTo(33)
            make.width.equalTo(37)
        }
        
        informParentView.addSubview(firstStar)
        firstStar.snp.makeConstraints { make in
            make.leading.equalTo(38)
            make.top.equalTo(productTitle.snp.bottom).offset(7)
            make.width.height.equalTo(18)
        }
        
        informParentView.addSubview(secondStar)
        secondStar.snp.makeConstraints { make in
            make.leading.equalTo(firstStar.snp.trailing).offset(9)
            make.centerY.equalTo(firstStar)
        }
        
        informParentView.addSubview(thirdStar)
        thirdStar.snp.makeConstraints { make in
            make.leading.equalTo(secondStar.snp.trailing).offset(9)
            make.centerY.equalTo(secondStar)
        }
        
        informParentView.addSubview(fourthStar)
        fourthStar.snp.makeConstraints { make in
            make.leading.equalTo(thirdStar.snp.trailing).offset(9)
            make.centerY.equalTo(thirdStar)
        }
        
        informParentView.addSubview(fifthStar)
        fifthStar.snp.makeConstraints { make in
            make.leading.equalTo(fourthStar.snp.trailing).offset(9)
            make.centerY.equalTo(fourthStar)
        }
        
        fifthStar.addSubview(hideStar)
        hideStar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(17)
            make.leading.equalTo(10)
        }
        
        informParentView.addSubview(shopButton)
        shopButton.snp.makeConstraints { make in
            make.leading.equalTo(45)
            make.top.equalTo(fifthStar.snp.bottom).offset(32)
        }
        
        informParentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(shopButton)
        }
        
        informParentView.addSubview(featuresButton)
        featuresButton.snp.makeConstraints { make in
            make.leading.equalTo(detailButton.snp.trailing).offset(55)
            make.centerY.equalTo(detailButton)
        }
    }
}


extension DetailViewController: DetailView{
    func fetchData(productDetail: ProductDetail) {
        self.productDetail = productDetail
        wheelProductCollection.reloadData()
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWheelCollectionCell.identifier, for: indexPath) as? DetailWheelCollectionCell else { return DetailWheelCollectionCell()}
        cell.backgroundColor = .orange
        cell.fetchData(link: productDetail?.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wheelProductCollection.frame.width, height: wheelProductCollection.frame.height)
    }
    
}
