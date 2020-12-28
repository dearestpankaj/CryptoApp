//
//  WalletsTableViewCell.swift
//  CryptoApp
//
//  Created by Administrator on 26/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import SVGKit

class WalletsTableViewCell: UITableViewCell {
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var walletBalanceLabel: UILabel!
    @IBOutlet weak var walletIconView: UIView!
    @IBOutlet weak var defaultWalletView: UIView!
    @IBOutlet weak var walletIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var walletIconWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        walletIconWidthConstraint.constant = CGFloat(Constants.iconWidth)
        walletIconHeightConstraint.constant = CGFloat(Constants.iconHeight)
    }
    
    func set(cryptoWallet: CryptoWallet) {
        walletNameLabel.text = cryptoWallet.name + " (\(cryptoWallet.symbol ?? ""))"
        walletBalanceLabel.text = cryptoWallet.balance
        
        if let logo = cryptoWallet.logo {
            let walletImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: Constants.iconWidth, height: Constants.iconHeight))
            walletImageView.loadImageUsingCache(withUrl: logo)
            walletIconView.addSubview(walletImageView)
        }
        
        if let isDefault = cryptoWallet.isDefault, isDefault, cryptoWallet.currencyType == .wallet {
            defaultWalletView.backgroundColor = Constants.defaultWalletMarkerColor
        } else {
            defaultWalletView.backgroundColor = UIColor.systemBackground
        }
        
        if cryptoWallet.currencyType == .fiatWallet {
            self.backgroundColor = Constants.fiatWalletBackgroundColor
        } else {
            self.backgroundColor = UIColor.systemBackground
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
