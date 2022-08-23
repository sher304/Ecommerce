//
//  Network.swift
//  Ecommerce
//
//  Created by Шермат Эшеров on 22/8/22.
//

import Foundation
import Alamofire


protocol NetworkService{
    func parseDatas(completion: @escaping(Product) -> Void)
    func parseSingleElement(completion: @escaping(ProductDetail) -> Void)
    func parseCart(completion: @escaping(CartProduct) -> Void)
}


class Network: NetworkService{
    let session = URLSession.shared
    func parseDatas(completion: @escaping(Product) -> Void){
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }
        AF.request(url).response { responce in
            DispatchQueue.main.async {
                guard let data = responce.data else { return }
                guard let decoderData = try? JSONDecoder().decode(Product.self, from: data) else { return }
                completion(decoderData)
            }
        }
    }
    
    
    func parseSingleElement(completion: @escaping (ProductDetail) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5") else { return }
        AF.request(url).response { responce in
            DispatchQueue.main.async {
                guard let data = responce.data else { return }
                guard let dedoderData = try? JSONDecoder().decode(ProductDetail.self, from: data) else { return }
                completion(dedoderData)
            }
        }
    }
    
    func parseCart(completion: @escaping(CartProduct) -> Void){
        guard let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149") else { return }
        AF.request(url).response { responce in
            DispatchQueue.main.async {
                guard let data = responce.data else {
                    return }
                guard let dedoderData = try? JSONDecoder().decode(CartProduct.self, from: data) else {
                    return }
                completion(dedoderData)
            }
        }
    }
    
}
