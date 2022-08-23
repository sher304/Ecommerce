//
//  DetailBuilder.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation
import UIKit


class DetailBuilder{
    
    static func build() -> UIViewController{
        let vc = DetailViewController()
        let presenter = DetailPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }

}
