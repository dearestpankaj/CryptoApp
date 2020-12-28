//
//  UIView+Gradient.swift
//  CryptoApp
//
//  Created by Administrator on 27/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit

extension String {
    func currencyFormatting(precesion: Int) -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = precesion
            formatter.locale = Locale.current
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
