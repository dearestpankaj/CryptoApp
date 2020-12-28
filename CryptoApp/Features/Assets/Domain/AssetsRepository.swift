//
//  AssetsRepository.swift
//  CryptoApp
//
//  Created by Administrator on 20/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

protocol AssetsRepositoryProtocol {
    func cryptoCoins() -> [DataAttributes]
}

import Foundation

class AssetsRepository: AssetsRepositoryProtocol {
    func cryptoCoins() -> [DataAttributes] {
        var cryptoDataAttributes = [DataAttributes]()
        if let url = Bundle.main.url(forResource: "masterData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let cryptoData = try JSONDecoder().decode(CryptoData.self, from: data) as CryptoData
                cryptoDataAttributes = [cryptoData.data.attributes]
            } catch {
                 // handle error
            }
        }
        return cryptoDataAttributes
    }
}
