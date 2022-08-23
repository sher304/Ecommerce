//
//  HomeViewController.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarConstaints()
    }
    
    
    private func generateTabBar(){
        viewControllers = [generateVC(vc: MainBuilder.build(), title: "Home", image: UIImage(systemName: "house.fill")),
                   generateVC(vc: CartViewController(), title: "Cart", image: UIImage(systemName: "cart.fill"))
        ]
    }
    
    private func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController{
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
    private func setTabBarConstaints(){
        let positionX: CGFloat = 10
        let posistionY: CGFloat = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + posistionY * 2
        let roundLayer = CAShapeLayer()
        let beizerPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: posistionY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = beizerPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
    }
    
}
