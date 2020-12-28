//
//  WalletsService.swift
//  CryptoApp
//
//  Created by Administrator on 27/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import Foundation

protocol WalletsServiceProtocol {
    func getWallets() -> [CurrencyType: [CryptoWalletItem]]
}

class WalletsService: WalletsServiceProtocol {
    let assetsRepository: AssetsRepositoryProtocol

    init(assetsRepository: AssetsRepositoryProtocol) {
        self.assetsRepository = assetsRepository
    }
    
    /// Get all wallets from Asset Repository and convert to a dictionary
    func getWallets() -> [CurrencyType: [CryptoWalletItem]] {
        var wallets: [CurrencyType: [CryptoWalletItem]] = [:]
        let cryptoItems = self.assetsRepository.cryptoCoins()
        wallets[.wallet] = getWallets(cryptoDataAttributes: cryptoItems)
        wallets[.fiatWallet] = getFiatWallets(cryptoDataAttributes: cryptoItems)
        wallets[.commodityWallet] = getCommodityWallets(cryptoDataAttributes: cryptoItems)
        return wallets
    }
    
    /// Get wallets with image url from cryptocoins
    /// - Parameter cryptoDataAttributes: crypto Items received from Repository
    private func getWallets(cryptoDataAttributes: [DataAttributes]) -> [CryptoWalletItem] {
        let walletsList: [CryptoWalletItem] = cryptoDataAttributes[0].wallets.map {
            let cryptocoinId = $0.attributes.cryptocoinID
            let commodityAttributes = getWalletURL(commodities:
                cryptoDataAttributes[0].cryptocoins, commodityId: cryptocoinId)
            return CryptoWalletItem(logo: commodityAttributes.logo,
                                    logoDark: commodityAttributes.logoDark,
                                    name: $0.attributes.name,
                                    symbol: $0.attributes.cryptocoinSymbol,
                                    balance: $0.attributes.balance,
                                    isDefault: $0.attributes.isDefault,
                                    isDeleted: $0.attributes.deleted)
        }
        return walletsList
    }
    
    /// Get fiat wallets with image url from fiats
    /// - Parameter cryptoDataAttributes: crypto Items received from Repository
    private func getFiatWallets(cryptoDataAttributes: [DataAttributes]) -> [CryptoWalletItem] {
        let walletsList: [CryptoWalletItem] = cryptoDataAttributes[0].fiatwallets.map {
            let fiatId = $0.attributes.fiatID
            let commodityAttributes = getFiatURL(fiats: cryptoDataAttributes[0].fiats, fiatId: fiatId)
            return CryptoWalletItem(logo: commodityAttributes.logo,
                                    logoDark: commodityAttributes.logoDark,
                                    name: $0.attributes.name,
                                    symbol: $0.attributes.fiatSymbol,
                                    balance: $0.attributes.balance,
                                    isDefault: nil,
                                    isDeleted: nil)
        }
        return walletsList
    }
    
    /// Get commodities wallet with image url from commodities
    /// - Parameter cryptoDataAttributes: crypto Items received from Repository
    private func getCommodityWallets(cryptoDataAttributes: [DataAttributes]) -> [CryptoWalletItem] {
        let walletsList: [CryptoWalletItem] = cryptoDataAttributes[0].commodityWallets.map {
            let cryptocoinID = $0.attributes.cryptocoinID
            let commodityAttributes = getWalletURL(commodities:
                cryptoDataAttributes[0].commodities, commodityId: cryptocoinID)
            return CryptoWalletItem(logo: commodityAttributes.logo,
                                    logoDark: commodityAttributes.logoDark,
                                    name: $0.attributes.name,
                                    symbol: $0.attributes.cryptocoinSymbol,
                                    balance: $0.attributes.balance,
                                    isDefault: $0.attributes.isDefault,
                                    isDeleted: $0.attributes.deleted)
        }
        return walletsList
    }
    
    /// Search image url for commodity in comodities array
    /// - Parameters:
    ///   - commodities: array of commodity
    ///   - commodityId: commodity id to be searched
    private func getWalletURL(commodities: [Commodity], commodityId: String) -> CommodityAttributes {
        let comodity = commodities.filter {$0.id == commodityId}
        return comodity[0].attributes
    }
    
    /// Search Fiat url for Fiats in Fiat url
    /// - Parameters:
    ///   - fiats: array of fiats
    ///   - fiatId: fiat id to be searched
    private func getFiatURL(fiats: [Fiat], fiatId: String) -> FiatAttributes {
        let comodity = fiats.filter {$0.id == fiatId}
        return comodity[0].attributes
    }
}
struct CryptoWalletItem {
    let logo: String?
    let logoDark: String?
    let name: String
    let symbol: String?
    let balance: String
    let isDefault: Bool?
    let isDeleted: Bool?
}
