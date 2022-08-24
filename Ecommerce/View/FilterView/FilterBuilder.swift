//
//  FilterBuilder.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 24/8/22.
//

import Foundation
import UIKit


class FilterBuilder{
    
    static func build() -> UIViewController{
        let vc = FilterViewController()
        let presenter = FilterPresenter(view: vc)
        vc.presenter = presenter
        return vc   
    }
}
