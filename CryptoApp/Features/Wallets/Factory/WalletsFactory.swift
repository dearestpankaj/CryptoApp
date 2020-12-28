//
//  WalletsFactory.swift
//  CryptoApp
//
//  Created by Administrator on 27/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import Foundation

protocol WalletsFactoryProtocol {
    func makeWalletsService() -> WalletsService
    func makeWalletsViewModel() -> WalletsViewModel
}

class WalletsFactory: WalletsFactoryProtocol {
    func makeWalletsService() -> WalletsService {
        let assetsRepository = makeAssetsRepository()
        return WalletsService(assetsRepository: assetsRepository)
    }
    
    func makeWalletsViewModel() -> WalletsViewModel {
        let walletsViewModel = WalletsViewModel(walletsService: makeWalletsService())
        return walletsViewModel
    }

    private func makeAssetsRepository() -> AssetsRepository {
        return AssetsRepository()
    }
}
