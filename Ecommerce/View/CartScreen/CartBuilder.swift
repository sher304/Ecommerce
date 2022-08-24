//
//  CartBuilder.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit


class CartBuilder{
    
    static func build() -> UIViewController{
        let vc = CartViewController()
        let presenter = CartPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
}
