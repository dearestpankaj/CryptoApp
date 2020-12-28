//
//  AssetsViewController.swift
//  CryptoApp
//
//  Created by Administrator on 20/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import UIKit

class AssetsViewController: UIViewController {
    @IBOutlet weak var assetsSegmentView: UISegmentedControl!
    @IBOutlet weak var assetsTableView: UITableView!

    var assetsViewModel: AssetsViewModelProtocol! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Assets"
        let assetsFactory = AssetsFactory()
        assetsViewModel = assetsFactory.makeAssetssViewModel()
        assetsViewModel.isDarkMode = (self.traitCollection.userInterfaceStyle == .dark)
    }

    @IBAction func assetSelectionChangeAction(_ sender: UISegmentedControl) {
        guard let currencyType = CurrencyType(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        assetsViewModel.selectedCurrecyType = currencyType
        assetsTableView.reloadData()
    }
}

extension AssetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assetsViewModel.currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? AssetsTableViewCell {
            cell.set(cryptoCurrency: self.assetsViewModel.currencies[indexPath.row])
        }
        return cell
    }
}
