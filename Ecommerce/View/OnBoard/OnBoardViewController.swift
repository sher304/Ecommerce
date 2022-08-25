//
//  OnBoardViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 25/8/22.
//

import UIKit
import SnapKit

class OnBoardViewController: UIViewController {
    
    private lazy var circleImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.customOrangeTint
        image.layer.cornerRadius = 132 / 2
        return image
    }()

    private lazy var companyTitle: UILabel = {
        let label = UILabel()
        label.text = "Ecommerce Concept"
        label.font = UIFont(name: "Mark Pro Heavy", size: 30)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        pushToMainView()
    }
    
    func setView(){
        view.backgroundColor = UIColor.customDarkBlue
    }
    
    func setupConstraints(){
        setView()
        view.addSubview(circleImage)
        circleImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(132)
        }
        
        circleImage.addSubview(companyTitle)
        companyTitle.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.leading.equalTo(34)
            make.width.equalTo(200)
        }
    }
    
    func pushToMainView(){
        DispatchQueue.main.async {
            sleep(2)
            let vc = TabBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
