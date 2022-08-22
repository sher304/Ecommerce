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
}


class Network: NetworkService{
    let session = URLSession.shared
    func parseDatas(completion: @escaping(Product) -> Void){
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }
        AF.request(url).response { responce in
            guard let data = responce.data else { return }
            guard let decoderData = try? JSONDecoder().decode(Product.self, from: data) else { return }
            completion(decoderData)
        }
    }
}
