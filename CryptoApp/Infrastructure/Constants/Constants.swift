//
//  Constants.swift
//  CryptoApp
//
//  Created by Administrator on 28/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit

enum CurrencyType: Int {
    case cryptocurrency
    case commodity
    case fiat
    case wallet
    case commodityWallet
    case fiatWallet
}
struct Constants {
    static let defaultWalletMarkerColor = UIColor.systemPink
    static let fiatWalletBackgroundColor = UIColor.systemTeal
    static let defaultPrecisionCurrency = 2
    static let iconHeight = 60
    static let iconWidth = 60
}
