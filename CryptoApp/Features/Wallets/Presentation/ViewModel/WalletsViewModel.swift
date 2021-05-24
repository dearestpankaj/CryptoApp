//
//  WalletsViewModel.swift
//  CryptoApp
//
//  Created by Administrator on 25/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import Foundation

protocol WalletsViewModelProtocol {
    var wallets: [CurrencyType: [CryptoWallet]] { get set }
    var isDarkMode: Bool { get set }
}

class WalletsViewModel: WalletsViewModelProtocol {
    var wallets: [CurrencyType: [CryptoWallet]] = [:]

    let walletsService: WalletsServiceProtocol

    var isDarkMode: Bool

    init(walletsService: WalletsServiceProtocol) {
        self.walletsService = walletsService
        self.isDarkMode = false
        
        getWallets()
    }
    
    /// getWallets from Service layer and convert in dictionary, also sort the array items on the basis of balance and remove deleted wallets
    private func getWallets() {
        let cryptocoins = self.walletsService.getWallets()
        getCryptoWallets(cryptoAssets: cryptocoins, cryptoType: .wallet)
        getCryptoWallets(cryptoAssets: cryptocoins, cryptoType: .commodityWallet)
        getCryptoWallets(cryptoAssets: cryptocoins, cryptoType: .fiatWallet)
    }
    
    private func getCryptoWallets(cryptoAssets: [CurrencyType: [CryptoWalletItem]],
                                     cryptoType: CurrencyType) {
        if let fiatWalletList = cryptoAssets[cryptoType] {
            let cryptoWalletList = fiatWalletList.filter { !($0.isDeleted ?? false) }.map {
                return CryptoWallet(logo: isDarkMode ? $0.logoDark : $0.logo,
                                    name: $0.name,
                                    symbol: $0.symbol,
                                    balance: $0.balance,
                                    currencyType: .fiatWallet,
                                    isDefault: $0.isDefault)
            }
            let sortedWalletList = cryptoWalletList.sorted(by: {
                (Double($0.balance) ?? 0) > (Double($1.balance) ?? 0)
            })
            wallets[cryptoType] = sortedWalletList
        }
    }
}
struct CryptoWallet {
    let logo: String?
    let name: String
    let symbol: String?
    let balance: String
    let currencyType: CurrencyType
    let isDefault: Bool?
}
