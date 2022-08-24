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
    func sendToCartScreen()
}

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter?
    
    var productDetail: ProductDetail? = nil
    
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.contentSize = contentSize
        scrollV.frame = view.bounds
        scrollV.backgroundColor = UIColor.customBackgroundWhite
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = view.backgroundColor
        return view
    }()
    
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
        button.addTarget(self, action: #selector(addTocartTappet), for: .touchUpInside)
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
        collectionV.backgroundColor = view.backgroundColor
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
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
        button.addTarget(self, action: #selector(favTappet), for: .touchUpInside)
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
    
    private lazy var elementCollectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(ElementsCustomCell.self, forCellWithReuseIdentifier: ElementsCustomCell.indentifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        return collectionV
    }()
    
    private lazy var cpuImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "cpu")
        imageV.tintColor = UIColor.customGray
        return imageV
    }()
    
    private lazy var cpuTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 11)
        label.textColor = UIColor.customGray
        return label
    }()
    
    private lazy var cameraImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "camera")
        imageV.tintColor = UIColor.customGray
        return imageV
    }()
    
    private lazy var cameraTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 11)
        label.textColor = UIColor.customGray
        return label
    }()
    
    private lazy var ssdImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "memorychip")
        imageV.tintColor = UIColor.customGray
        return imageV
    }()
    
    private lazy var ssdTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 11)
        label.textColor = UIColor.customGray
        return label
    }()
    
    private lazy var sdcardImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "sdcard")
        imageV.tintColor = UIColor.customGray
        return imageV
    }()
    
    private lazy var sdcardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 11)
        label.textColor = UIColor.customGray
        return label
    }()
    
    private lazy var selectColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Select color and capacity"
        label.textColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Makr Pro Medium", size: 16)
        return label
    }()
    
    private lazy var brownButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customBrown
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 40 / 2
        button.addTarget(self, action: #selector(colorTappet), for: .touchUpInside)
        return button
    }()
    
    private lazy var darkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customDarkBlue
        button.tintColor = .white
        button.layer.cornerRadius = 40 / 2
        button.addTarget(self, action: #selector(colorTappet), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectGB128: UIButton = {
        let button = UIButton()
        button.setTitle("128 GB", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 13)
        button.addTarget(self, action: #selector(selectGB), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectGB256: UIButton = {
        let button = UIButton()
        button.setTitle("256 GB", for: .normal)
        button.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro", size: 13)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(selectGB), for: .touchUpInside)
        return button
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customOrangeTint
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 20)
        button.addTarget(self, action: #selector(addTocartTappet), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupConstraints()
        setupNavBar()
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(), landscapeImagePhone: UIImage(), style: .done, target: nil, action: nil)
    }
    
    
    func setupConstraints(){
        
        contentView.addSubview(titleSceen)
        titleSceen.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(86)
        }
        
        contentView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(42)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        contentView.addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.trailing.equalTo(-35)
            make.top.equalTo(79)
            make.width.height.equalTo(37)
        }
        
        contentView.addSubview(wheelProductCollection)
        wheelProductCollection.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(330)
            make.top.equalTo(titleSceen.snp.bottom).offset(37)
        }
        
        contentView.addSubview(informParentView)
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
        
        
        informParentView.addSubview(elementCollectionView)
        elementCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fourthStar.snp.bottom).offset(32)
            make.height.equalTo(26)
            make.leading.equalTo(45)
            make.trailing.equalTo(-45)
        }
        
        informParentView.addSubview(cpuImage)
        cpuImage.snp.makeConstraints { make in
            make.leading.equalTo(45)
            make.width.height.equalTo(28)
            make.top.equalTo(elementCollectionView.snp.bottom).offset(35)
        }
        
        informParentView.addSubview(cpuTitle)
        cpuTitle.snp.makeConstraints { make in
            make.centerX.equalTo(cpuImage)
            make.top.equalTo(cpuImage.snp.bottom).offset(5)
        }
        
        informParentView.addSubview(cameraImage)
        cameraImage.snp.makeConstraints { make in
            make.leading.equalTo(cpuImage.snp.trailing).offset(74)
            make.centerY.equalTo(cpuImage)
            make.width.equalTo(28)
            make.height.equalTo(22)
        }
        
        informParentView.addSubview(cameraTitle)
        cameraTitle.snp.makeConstraints { make in
            make.centerY.equalTo(cpuTitle)
            make.centerX.equalTo(cameraImage)
        }
        
        informParentView.addSubview(ssdImage)
        ssdImage.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(21)
            make.centerY.equalTo(cameraImage)
            make.leading.equalTo(cameraImage.snp.trailing).offset(64)
        }
        
        informParentView.addSubview(ssdTitle)
        ssdTitle.snp.makeConstraints { make in
            make.centerX.equalTo(ssdImage)
            make.centerY.equalTo(cameraTitle)
        }
        
        informParentView.addSubview(sdcardImage)
        sdcardImage.snp.makeConstraints { make in
            make.leading.equalTo(ssdImage.snp.trailing).offset(68)
            make.centerY.equalTo(ssdImage)
        }
        
        informParentView.addSubview(sdcardTitle)
        sdcardTitle.snp.makeConstraints { make in
            make.centerY.equalTo(ssdTitle)
            make.centerX.equalTo(sdcardImage)
        }
        
        informParentView.addSubview(selectColorLabel)
        selectColorLabel.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.top.equalTo(cameraTitle.snp.bottom).offset(29)
        }
        
        informParentView.addSubview(brownButton)
        brownButton.snp.makeConstraints { make in
            make.leading.equalTo(35)
            make.top.equalTo(selectColorLabel.snp.bottom).offset(15)
            make.width.height.equalTo(40)
        }
        
        informParentView.addSubview(darkButton)
        darkButton.snp.makeConstraints { make in
            make.leading.equalTo(brownButton.snp.trailing).offset(18)
            make.width.height.equalTo(40)
            make.centerY.equalTo(brownButton)
        }
        
        informParentView.addSubview(selectGB128)
        selectGB128.snp.makeConstraints { make in
            make.leading.equalTo(darkButton.snp.trailing).offset(58)
            make.centerY.equalTo(darkButton)
            make.width.equalTo(71)
            make.height.equalTo(30)
        }
        
        informParentView.addSubview(selectGB256)
        selectGB256.snp.makeConstraints { make in
            make.leading.equalTo(selectGB128.snp.trailing).offset(20)
            make.centerY.equalTo(selectGB128)
            make.width.equalTo(71)
            make.height.equalTo(30)
        }
        
        informParentView.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.leading.equalTo(29)
            make.trailing.equalTo(-30)
            make.height.equalTo(54)
            make.bottom.equalTo(-58)
        }
    }
    
    func setupDatas(){
        DispatchQueue.main.async { [self] in
            productTitle.text = productDetail?.title
            cpuTitle.text = productDetail?.cpu
            cameraTitle.text = productDetail?.camera
            ssdTitle.text = productDetail?.ssd
            sdcardTitle.text = productDetail?.sd
            addToCartButton.setTitle("Add to Cart                 $\(productDetail?.price ?? Int())", for: .normal)
            if productDetail?.isFavorites ?? Bool(){
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    @objc func selectGB(btn: UIButton){
        if btn == selectGB256{
            selectGB256.backgroundColor = UIColor.customOrangeTint
            selectGB256.setTitleColor(.white, for: .normal)
            selectGB128.backgroundColor = .clear
            selectGB128.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        }else{
            selectGB128.backgroundColor = UIColor.customOrangeTint
            selectGB128.setTitleColor(.white, for: .normal)
            selectGB256.backgroundColor = .clear
            selectGB256.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        }
    }
    
    @objc func colorTappet(btn: UIButton){
        if btn == brownButton{
            brownButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            darkButton.setImage(UIImage(), for: .normal)
        }else{
            darkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            brownButton.setImage(UIImage(), for: .normal)
        }
    }
    
    var validator = true
    @objc func favTappet(){
        if validator{
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            validator = false
        }else{
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            validator = true
        }
    }
    
    @objc func addTocartTappet(){
        sendToCartScreen()
    }
}


extension DetailViewController: DetailView{
    func fetchData(productDetail: ProductDetail) {
        self.productDetail = productDetail
        wheelProductCollection.reloadData()
        setupDatas()
    }
    
    func sendToCartScreen(){
        let vc = CartBuilder.build()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wheelProductCollection{
            return productDetail?.images.count ?? 0
        }else{
            return presenter?.elements.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wheelProductCollection{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWheelCollectionCell.identifier, for: indexPath) as? DetailWheelCollectionCell else { return DetailWheelCollectionCell()}
            cell.fetchData(link: productDetail?.images[indexPath.row])
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementsCustomCell.indentifier, for: indexPath) as? ElementsCustomCell else { return ElementsCustomCell()}
            guard let items = presenter?.elements[indexPath.row] else { return ElementsCustomCell()}
            cell.fetchData(title: items)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == wheelProductCollection{
            return CGSize(width: wheelProductCollection.frame.width, height: wheelProductCollection.frame.height)
        }else{
            return CGSize(width: elementCollectionView.frame.width / 3.3, height: 25)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ElementsCustomCell {
            cell.didSelected()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ElementsCustomCell {
            cell.cancelSelected()
        }
    }
    
}
extension DetailViewController: UIScrollViewDelegate{
    //MARK: Scroll Down, Hide Navbar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            //scrolling down
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        //MARK: Scroll Up, Show Navbar
        else{
            //scrolling up
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
