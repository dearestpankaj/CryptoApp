//
//  AssetsFactory.swift
//  CryptoApp
//
//  Created by Administrator on 27/12/20.
//  Copyright © 2020 Pankaj Sachdeva. All rights reserved.
//

import Foundation

protocol AssetsFactoryProtocol {
    func makeAssetsRepository() -> AssetsRepository
    func makeAssetsService() -> AssetsService
    func makeAssetssViewModel() -> AssetsViewModel
}

class AssetsFactory: AssetsFactoryProtocol {
    func makeAssetsRepository() -> AssetsRepository {
        return AssetsRepository()
    }
    
    func makeAssetsService() -> AssetsService {
        return AssetsService(assetsRepository: makeAssetsRepository())
    }

    func makeAssetssViewModel() -> AssetsViewModel {
        return AssetsViewModel(assetsService: makeAssetsService())
    }
}
