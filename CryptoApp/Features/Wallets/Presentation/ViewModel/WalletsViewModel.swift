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
        if let walletList = cryptocoins[.wallet] {
            let cryptoWalletList = walletList.filter { !($0.isDeleted ?? false) }.map {
                return CryptoWallet(logo: isDarkMode ? $0.logoDark : $0.logo,
                                    name: $0.name,
                                    symbol: $0.symbol,
                                    balance: $0.balance,
                                    currencyType: .wallet,
                                    isDefault: $0.isDefault)
            }
            let sortedWalletList = cryptoWalletList.sorted(by: {
                (Double($0.balance) ?? 0) > (Double($1.balance) ?? 0)
            })
            wallets[.wallet] = sortedWalletList
        }
        if let commodityWalletList = cryptocoins[.commodityWallet] {
            let cryptoWalletList = commodityWalletList.filter { !($0.isDeleted ?? false) }.map {
                return CryptoWallet(logo: isDarkMode ? $0.logoDark : $0.logo,
                                    name: $0.name,
                                    symbol: $0.symbol,
                                    balance: $0.balance,
                                    currencyType: .commodityWallet,
                                    isDefault: $0.isDefault)
            }
            let sortedWalletList = cryptoWalletList.sorted(by: {
                (Double($0.balance) ?? 0) > (Double($1.balance) ?? 0)
            })
            wallets[.commodityWallet] = sortedWalletList
        }
        if let fiatWalletList = cryptocoins[.fiatWallet] {
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
            wallets[.fiatWallet] = sortedWalletList
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
