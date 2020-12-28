//
//  AssetsTableViewCell.swift
//  CryptoApp
//
//  Created by Administrator on 20/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import SVGKit

class AssetsTableViewCell: UITableViewCell {
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetIconView: UIView!
    @IBOutlet weak var assetIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var assetIconWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(cryptoCurrency: CryptoCurrency) {
        assetNameLabel.text = (cryptoCurrency.name ?? "") + " (\(cryptoCurrency.symbol ?? ""))"
        if let averagePrice = cryptoCurrency.averagePrice {
            assetSymbolLabel.text = averagePrice.currencyFormatting(precesion: cryptoCurrency.precesion ?? Constants.defaultPrecisionCurrency)
        }
        
        let assetImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: Constants.iconWidth, height: Constants.iconHeight))
        assetImageView.loadImageUsingCache(withUrl: cryptoCurrency.logo ?? "")
        assetIconView.addSubview(assetImageView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
