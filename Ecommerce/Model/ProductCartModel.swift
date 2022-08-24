//
//  ProductCartModel.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 23/8/22.
//

import Foundation

// MARK: - CartProduct
struct CartProduct: Codable {
    let basket: [Basket]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
struct Basket: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
