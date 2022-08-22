//
//  ViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import UIKit
import SnapKit

protocol MainView: AnyObject{
    func reloadData()
    
}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterView!
    
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height + 160)
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.contentSize = contentSize
        scrollV.frame = view.bounds
        scrollV.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        return view
    }()
    
    
    private lazy var mapIcon: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "pin")
        return imageV
    }()
    
    private lazy var locationTitle: UILabel = {
        let label = UILabel()
        label.text = "Zihuatanejo, Gro"
        label.textColor = UIColor(red: 1/255, green: 0/255, blue: 53/255, alpha: 1)
        label.font = UIFont(name: "Mark Pro", size: 15)
        return label
    }()
    
    private lazy var downButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.tintColor = UIColor(red: 1/255, green: 0/255, blue: 53/255, alpha: 1)
        return button
    }()
    
    private lazy var categoriesTitle: UILabel = {
        let label = UILabel()
        label.text = "Select Category"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = UIColor(red: 1/255, green: 0/255, blue: 53/255, alpha: 1)
        return label
    }()
    
    private lazy var viewAllTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
        label.font = UIFont(name: "Mark Pro", size: 15)
        label.text = "view all"
        return label
    }()
    
    private lazy var collectionV: UICollectionView = {
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
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        searchB.searchTextField.leftView?.tintColor = .orange
        searchB.autocorrectionType = .no
        searchB.backgroundImage = UIImage()
        searchB.searchTextField.backgroundColor = .white
        searchB.layer.cornerRadius = 15
        searchB.layer.masksToBounds = true
        searchB.placeholder = "Search"
        return searchB
    }()
    
    private lazy var scanView: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "scan")
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    private lazy var scanViewBg: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 34 / 2
        view.layer.masksToBounds = true
        view.backgroundColor = .orange
        return view
    }()
    
    private lazy var salesLabel: UILabel = {
        let label = UILabel()
        label.text = "Hot sales"
        label.font = UIFont(name: "Mark Pro Bold", size: 25)
        label.textColor = UIColor(red: 1/255, green: 0/255, blue: 53/255, alpha: 1)
        return label
    }()
    
    private lazy var seeMoreTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
        label.font = UIFont(name: "Mark Pro", size: 15)
        label.text = "see more"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        seupScrollView()
    }
    
    func seupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupUI()
    }
    
    func setupUI(){
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
            make.width.equalTo(10)
            make.height.equalTo(5)
        }
        
        contentView.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.trailing.equalTo(-35)
            make.centerY.equalTo(downButton)
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
        
        contentView.addSubview(collectionV)
        collectionV.snp.makeConstraints { make in
            make.leading.equalTo(27)
            make.top.equalTo(categoriesTitle.snp.bottom).offset(24)
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(collectionV.snp.bottom).offset(30)
            make.leading.equalTo(32)
            make.height.equalTo(34)
            make.width.equalTo(300)
        }
        
        contentView.addSubview(scanViewBg)
        scanViewBg.snp.makeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing).offset(11)
            make.width.height.equalTo(34)
            make.centerY.equalTo(searchBar)
        }
        
        scanViewBg.addSubview(scanView)
        scanView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
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
    }
}

extension MainViewController: MainView{
    func reloadData(){
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollecitonCell.identifier, for: indexPath) as? CollecitonCell else { return CollecitonCell()}
        let items = presenter.items
        let images = presenter.images
        cell.fetchData(icon: images[indexPath.row], title: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 77, height: 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollecitonCell {
            cell.didSelected(indx: indexPath.row + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollecitonCell {
            cell.didDeselect(indx: indexPath.row + 1)
        }
    }
}

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