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
        image.alpha = 0
        return image
    }()
    
    private lazy var companyTitle: UILabel = {
        let label = UILabel()
        label.text = "Ecommerce Concept"
        label.font = UIFont(name: "Mark Pro Heavy", size: 30)
        label.numberOfLines = 0
        label.textColor = .white
        label.alpha = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        pushToMainView()
        onBoardAnimate()
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
        
        //        circleImage.addSubview(companyTitle)
        //        companyTitle.snp.makeConstraints { make in
        //            make.top.equalTo(32)
        //            make.leading.equalTo(34)
        //            make.width.equalTo(200)
        //        }
        
        view.addSubview(companyTitle)
        companyTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.centerX.equalToSuperview().offset(70)
        }
    }
    
    func pushToMainView(){
                DispatchQueue.main.async {
                    sleep(2)
                    let vc = MainBuilder.build()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
    }
    
    func onBoardAnimate(){
        UIView.animate(withDuration: 1) {
            self.circleImage.alpha = 1
        }
        
        UIView.animate(withDuration: 1, delay: 1, options: [.curveEaseIn]) {
            self.companyTitle.center.x += 50
            self.companyTitle.alpha = 1
        } completion: { _ in }
        
    }
}
