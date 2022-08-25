//
//  Builder.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import UIKit


class MainBuilder{
    
    //MARK: DI VC With Presenter
    static func build() -> UIViewController{
        let vc = MainViewController()
        let presenter = MainPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
}
