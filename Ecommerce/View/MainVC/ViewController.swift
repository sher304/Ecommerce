//
//  ViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import UIKit
import SnapKit

protocol MainView: AnyObject{
    func showProducts(products: Product)
}

class MainViewController: UIViewController {
    
    
    //MARK: Presenter
    var presenter: MainPresenter!
    
    //MARK: Products data
    var products: Product? = nil
    
    //MARK: Content Size Frame
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height + 360)
    
    //MARK: Scroll View
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.contentSize = contentSize
        scrollV.frame = view.bounds
        scrollV.backgroundColor = UIColor.customBackgroundWhite
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    //MARK: Content View
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = UIColor.customBackgroundWhite
        return view
    }()
    
    //MARK: Map Icon
    private lazy var mapIcon: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "pin")
        return imageV
    }()
    
    //MARK: Location Title
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.text = "Zihuatanejo, Gro"
        label.textColor = UIColor.customDarkBlue
        label.font = UIFont(name: "Mark Pro", size: 15)
        return label
    }()
    
    //MARK: Down Button
    private lazy var downButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
        return button
    }()
    
    //MARK: Filter Button
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.tintColor = UIColor.customDarkBlue
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Categoriese Big Title
    private lazy var categoriesTitle: UILabel = {
        let label = UILabel()
        label.text = "Select Category"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: view all title - Label
    private lazy var viewAllTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customOrangeTint
        label.font = UIFont(name: "Mark Pro", size: 15)
        label.text = "view all"
        return label
    }()
    
    //MARK: Collection of Categories
    private lazy var categoryCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(CollecitonCell.self, forCellWithReuseIdentifier: CollecitonCell.identifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = contentView.backgroundColor
        collectionV.showsHorizontalScrollIndicator = false
        return collectionV
    }()
    
    //MARK: Search Bar
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.backgroundColor = .white
        searchB.searchTextField.leftView?.tintColor = .orange
        searchB.autocorrectionType = .no
        searchB.backgroundImage = UIImage()
        searchB.searchTextField.backgroundColor = .white
        searchB.layer.cornerRadius = 15
        searchB.layer.masksToBounds = true
        searchB.placeholder = "Search"
        searchB.searchTextField.textColor = .black
        return searchB
    }()
    
    //MARK: Scan Button Near of Search Bar
    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.layer.cornerRadius = 34 / 2
        button.backgroundColor = UIColor.customOrangeTint
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: Hot Sales - Label
    private lazy var salesLabel: UILabel = {
        let label = UILabel()
        label.text = "Hot sales"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: See More - Label
    private lazy var seeMoreTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customOrangeTint
        label.font = UIFont(name: "Mark Pro", size: 15)
        label.text = "see more"
        return label
    }()
    
    //MARK: Images Wheel Collection View
    private lazy var wheelCollectionImage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(WheelCollectionCell.self, forCellWithReuseIdentifier: WheelCollectionCell.identifier)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.layer.cornerRadius = 25
        collectionV.layer.masksToBounds = true
        collectionV.backgroundColor = contentView.backgroundColor
        return collectionV
    }()
    
    //MARK: Best Seller label
    private lazy var bestSellerLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Seller"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = UIColor.customDarkBlue
        return label
    }()
    
    //MARK: See more Second Title
    private lazy var seeMoreSecondTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customOrangeTint
        label.font = UIFont(name: "Mark Pro", size: 15)
        label.text = "see more"
        return label
    }()
    
    //MARK: Products Table View
    private lazy var productsTableView: UITableView = {
        let tableV = UITableView()
        tableV.register(BestSellerTableCell.self, forCellReuseIdentifier: BestSellerTableCell.identifier)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor = contentView.backgroundColor
        tableV.showsVerticalScrollIndicator = false
        return tableV
    }()
    
    private lazy var customTabBarMenu: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customDarkBlue
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabBartapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeButtonLabel: UIButton = {
        let button = UIButton()
        button.setTitle("Explorer", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabBartapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 15)
        return button
    }()
    
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bag"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabBartapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabBartapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var personButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabBartapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        seupScrollView()
        setupNavBar()
    }
    
    //MARK: Settings of Scroll View
    func seupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setConstraints()
        setupTabBarConstraints()
    }
    
    //MARK: Settings of Navigation Bar
    func setupNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .clear
    }
    
    //MARK: Settings Constraints
    func setConstraints(){
        contentView.addSubview(mapIcon)
        mapIcon.snp.makeConstraints { make in
            make.leading.equalTo(132)
            make.width.equalTo(12)
            make.height.equalTo(15.31)
            make.top.equalTo(64)
        }
        
        contentView.addSubview(locationTitle)
        locationTitle.snp.makeConstraints { make in
            make.leading.equalTo(mapIcon.snp.trailing).offset(11)
            make.centerY.equalTo(mapIcon)
        }
        
        contentView.addSubview(downButton)
        downButton.snp.makeConstraints { make in
            make.leading.equalTo(locationTitle.snp.trailing).offset(8)
            make.centerY.equalTo(locationTitle)
        }
        
        contentView.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.trailing.equalTo(-35)
            make.centerY.equalTo(downButton)
            make.width.height.equalTo(25)
        }
        
        contentView.addSubview(categoriesTitle)
        categoriesTitle.snp.makeConstraints { make in
            make.leading.equalTo(17)
            make.top.equalTo(locationTitle.snp.bottom).offset(18)
        }
        
        contentView.addSubview(viewAllTitle)
        viewAllTitle.snp.makeConstraints { make in
            make.trailing.equalTo(-33)
            make.centerY.equalTo(categoriesTitle)
        }
        
        contentView.addSubview(categoryCollectionV)
        categoryCollectionV.snp.makeConstraints { make in
            make.leading.equalTo(27)
            make.top.equalTo(categoriesTitle.snp.bottom).offset(24)
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionV.snp.bottom).offset(30)
            make.leading.equalTo(32)
            make.height.equalTo(34)
            make.width.equalTo(300)
        }
        
        contentView.addSubview(scanButton)
        scanButton.snp.makeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing).offset(11)
            make.width.height.equalTo(34)
            make.centerY.equalTo(searchBar)
        }
        
        contentView.addSubview(salesLabel)
        salesLabel.snp.makeConstraints { make in
            make.leading.equalTo(17)
            make.top.equalTo(searchBar.snp.bottom).offset(24)
        }
        
        contentView.addSubview(seeMoreTitle)
        seeMoreTitle.snp.makeConstraints { make in
            make.trailing.equalTo(-33)
            make.centerY.equalTo(salesLabel)
        }
        
        contentView.addSubview(wheelCollectionImage)
        wheelCollectionImage.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(-21)
            make.height.equalTo(182)
            make.top.equalTo(salesLabel.snp.bottom).offset(8)
        }
        
        contentView.addSubview(bestSellerLabel)
        bestSellerLabel.snp.makeConstraints { make in
            make.leading.equalTo(17)
            make.top.equalTo(wheelCollectionImage.snp.bottom).offset(10)
        }
        
        contentView.addSubview(seeMoreSecondTitle)
        seeMoreSecondTitle.snp.makeConstraints { make in
            make.trailing.equalTo(-27)
            make.centerY.equalTo(bestSellerLabel)
        }
        
        contentView.addSubview(productsTableView)
        productsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bestSellerLabel.snp.bottom).offset(21)
            make.bottom.equalToSuperview()
        }
    }
    
    
    func setupTabBarConstraints(){
        view.addSubview(customTabBarMenu)
        customTabBarMenu.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(72)
            make.bottom.equalToSuperview()
        }
        
        customTabBarMenu.addSubview(homeButton)
        homeButton.snp.makeConstraints { make in
            make.leading.equalTo(68)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(8)
        }
        
        customTabBarMenu.addSubview(homeButtonLabel)
        homeButtonLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeButton.snp.trailing).offset(7)
            make.centerY.equalTo(homeButton)
        }
        
        customTabBarMenu.addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.centerY.equalTo(homeButton)
            make.leading.equalTo(homeButtonLabel.snp.trailing).offset(47)
            make.width.equalTo(17.54)
            make.height.equalTo(18)
        }
        
        customTabBarMenu.addSubview(favButton)
        favButton.snp.makeConstraints { make in
            make.centerY.equalTo(cartButton)
            make.leading.equalTo(cartButton.snp.trailing).offset(52)
            make.width.equalTo(19)
            make.height.equalTo(17)
        }
        customTabBarMenu.addSubview(personButton)
        personButton.snp.makeConstraints { make in
            make.leading.equalTo(favButton.snp.trailing).offset(52)
            make.centerY.equalTo(favButton)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
    }
    
    
    //MARK: Filter button Tapped
    @objc func filterTapped(){
        let vc = FilterBuilder.build()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func tabBartapped(btn: UIButton){
        if btn == homeButton || btn == homeButtonLabel{
            navigationController?.pushViewController(MainBuilder.build(), animated: true)
        }else if btn == cartButton{
            navigationController?.pushViewController(CartBuilder.build(), animated: true)
        }else if btn == favButton{
            navigationController?.pushViewController(DetailBuilder.build(), animated: true)
        }
    }
    
}

//MARK: Extension of VC Presenter
extension MainViewController: MainView{
    func showProducts(products: Product) {
        DispatchQueue.main.async { [self] in
            self.products = products
            wheelCollectionImage.reloadData()
            productsTableView.reloadData()
        }
    }
}

//MARK: Extension of Collection View
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionV{
            return presenter.items.count
        }
        else{
            return products?.homeStore.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionV{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollecitonCell.identifier, for: indexPath) as? CollecitonCell else { return CollecitonCell()}
            let items = presenter.items
            let images = presenter.images
            cell.fetchData(icon: images[indexPath.row], title: items[indexPath.row])
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheelCollectionCell.identifier, for: indexPath) as? WheelCollectionCell else { return WheelCollectionCell()}
            let images = products?.homeStore[indexPath.row]
            cell.fetchData(image: images?.picture ?? String(), title: images?.title ?? String(), descr: images?.subtitle ?? String(), isNew: images?.isNew ?? Bool())
            return cell
        }
    }
    
    //MARK: Set frame of Collection Sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionV{
            return CGSize(width: 77, height: 77)
        }else{
            return CGSize(width: wheelCollectionImage.frame.width, height: wheelCollectionImage.frame.height)
        }
    }
    
    //MARK: Category did selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollecitonCell {
            cell.didSelected(indx: indexPath.row + 1)
        }
    }
    
    //MARK: Category did deselected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollecitonCell {
            cell.didDeselect(indx: indexPath.row + 1)
        }
    }
}

//MARK: Extension of Table View
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: Amount of Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BestSellerTableCell()
        guard let items = products else { return BestSellerTableCell()}
        cell.fetchProducts(products: items, delegate: self)
        return cell
    }
    
    //MARK: Frame of Table Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return productsTableView.frame.height
    }
    
}

//MARK: Extension of Scroll View
extension MainViewController: UIScrollViewDelegate{
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


extension MainViewController: BestSellerDelegate{
    func didSelected() {
        self.navigationController?.pushViewController(DetailBuilder.build(), animated: true)
    }
}
