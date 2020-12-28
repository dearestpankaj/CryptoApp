//
//  AssetsViewModel.swift
//  CryptoApp
//
//  Created by Administrator on 20/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

protocol AssetsViewModelProtocol {
    var currencies: [CryptoCurrency] { get set }
    var selectedCurrecyType: CurrencyType { get set }
    var isDarkMode: Bool { get set }
}

import Foundation

class AssetsViewModel: AssetsViewModelProtocol {
    var currencies: [CryptoCurrency]
    /// onn selection change set the array with currencies
    var selectedCurrecyType: CurrencyType {
        didSet {
            switch selectedCurrecyType {
            case .cryptocurrency:
                currencies = allCurrencies[.cryptocurrency] ?? []
            case .commodity:
                currencies = allCurrencies[.commodity] ?? []
            case .fiat:
                currencies = allCurrencies[.fiat] ?? []
            default:
                currencies = allCurrencies[.cryptocurrency] ?? []
            }
        }
    }
    var isDarkMode: Bool

    var allCurrencies: [CurrencyType: [CryptoCurrency]]
    let assetsService: AssetsServiceProtocol
    
    init(assetsService: AssetsServiceProtocol) {
        self.currencies = [CryptoCurrency]()
        self.selectedCurrecyType = .cryptocurrency
        isDarkMode = false

        self.allCurrencies = [CurrencyType: [CryptoCurrency]]()
        self.assetsService = assetsService
        
        self.getAllCryptoCoins()
    }
    
    /// Get Cryptocoins from assetsService and save in dictionary, also maintain an array for currencies selected option in segment control
    private func getAllCryptoCoins() {
        let cryptoCurrencies = self.assetsService.getCryptoCurrencies()

        if let cryptocoins = cryptoCurrencies[.cryptocurrency] {
            allCurrencies[.cryptocurrency] = cryptocoins.map {
                return CryptoCurrency(logo: isDarkMode ? $0.logoDark : $0.logo,
                                      name: $0.name,
                                      symbol: $0.symbol,
                                      averagePrice: $0.averagePrice,
                                      currencyType: .cryptocurrency,
                                      precesion: $0.precesion)
            }
        }
        if let commodities = cryptoCurrencies[.commodity] {
            allCurrencies[.commodity] = commodities.map {
                return CryptoCurrency(logo: isDarkMode ? $0.logoDark : $0.logo,
                                      name: $0.name,
                                      symbol: $0.symbol,
                                      averagePrice: $0.averagePrice,
                                      currencyType: .cryptocurrency,
                                      precesion: $0.precesion)
            }
        }
        if let fiats = cryptoCurrencies[.fiat] {
            allCurrencies[.fiat] = fiats.filter { ($0.hasWallet ?? false) }.map {
                return CryptoCurrency(logo: isDarkMode ? $0.logoDark : $0.logo,
                                      name: $0.name,
                                      symbol: $0.symbol,
                                      averagePrice: $0.averagePrice,
                                      currencyType: .cryptocurrency,
                                      precesion: $0.precesion)
            }
        }
        currencies = allCurrencies[.cryptocurrency] ?? []
    }
}
struct CryptoCurrency {
    let logo: String?
    let name: String?
    let symbol: String?
    let averagePrice: String?
    let currencyType: CurrencyType
    let precesion: Int?
}
