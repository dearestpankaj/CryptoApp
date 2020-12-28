//
//  WalletViewController.swift
//  CryptoApp
//
//  Created by Administrator on 25/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit

class WalletsViewController: UIViewController {
    var walletsViewModel: WalletsViewModelProtocol! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wallets"
        
        let walletsFactory = WalletsFactory()
        walletsViewModel = walletsFactory.makeWalletsViewModel()
        walletsViewModel.isDarkMode = (self.traitCollection.userInterfaceStyle == .dark)
    }
}
extension WalletsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Wallets"
        } else if section == 1 {
            return "Fiat Wallets"
        } else {
            return "Commodity Wallets"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let wallets = self.walletsViewModel.wallets[.wallet]
            return wallets!.count
        } else if section == 1 {
            let fiatWallets = self.walletsViewModel.wallets[.fiatWallet]
            return fiatWallets!.count
        } else {
            let commodityWallets = self.walletsViewModel.wallets[.commodityWallet]
            return commodityWallets!.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? WalletsTableViewCell {
            if indexPath.section == 0 {
                let wallets = self.walletsViewModel.wallets[.wallet]
                cell.set(cryptoWallet: wallets![indexPath.row])
            } else if indexPath.section == 1 {
                let wallets = self.walletsViewModel.wallets[.fiatWallet]
                cell.set(cryptoWallet: wallets![indexPath.row])
            } else {
                let wallets = self.walletsViewModel.wallets[.commodityWallet]
                cell.set(cryptoWallet: wallets![indexPath.row])
            }
        }
        return cell
    }
}
