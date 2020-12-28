//
//  AssetsService.swift
//  CryptoApp
//
//  Created by Administrator on 20/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

protocol AssetsServiceProtocol {
    func getCryptoCurrencies() -> [CurrencyType: [CryptoCurrencyItem]]
}

import Foundation

class AssetsService: AssetsServiceProtocol {
    let assetsRepository: AssetsRepositoryProtocol
    var currencies: [DataAttributes]

    init(assetsRepository: AssetsRepositoryProtocol) {
        self.assetsRepository = AssetsRepository()
        self.currencies = self.assetsRepository.cryptoCoins()
    }
    
    /// Fetch currencies from Repository and convert in dictionary format
    func getCryptoCurrencies() -> [CurrencyType: [CryptoCurrencyItem]] {
        var wallets: [CurrencyType: [CryptoCurrencyItem]] = [:]
        let cryptoAssets = self.assetsRepository.cryptoCoins()
        wallets[.cryptocurrency] = cryptoAssets[0].cryptocoins.map {
            return CryptoCurrencyItem(logo: $0.attributes.logo,
                                      logoDark: $0.attributes.logoDark,
                                      name: $0.attributes.name,
                                      symbol: $0.attributes.symbol,
                                      averagePrice: $0.attributes.avgPrice,
                                      currencyType: .cryptocurrency,
                                      precesion: $0.attributes.precisionForFiatPrice,
                                      hasWallet: nil)
        }
        wallets[.commodity] = cryptoAssets[0].commodities.map {
            return CryptoCurrencyItem(logo: $0.attributes.logo,
                                      logoDark: $0.attributes.logoDark,
                                      name: $0.attributes.name,
                                      symbol: $0.attributes.symbol,
                                      averagePrice: $0.attributes.avgPrice,
                                      currencyType: .commodity,
                                      precesion: $0.attributes.precisionForFiatPrice,
                                      hasWallet: nil)
        }
        wallets[.fiat] = cryptoAssets[0].fiats.map {
            return CryptoCurrencyItem(logo: $0.attributes.logo,
                                      logoDark: $0.attributes.logoDark,
                                      name: $0.attributes.name,
                                      symbol: $0.attributes.symbol,
                                      averagePrice: nil,
                                      currencyType: .cryptocurrency,
                                      precesion: $0.attributes.precision,
                                      hasWallet: $0.attributes.hasWallets)
        }
        return wallets
    }
    
}
struct CryptoCurrencyItem {
    let logo: String?
    let logoDark: String?
    let name: String?
    let symbol: String?
    let averagePrice: String?
    let currencyType: CurrencyType
    let precesion: Int?
    let hasWallet: Bool?
}
