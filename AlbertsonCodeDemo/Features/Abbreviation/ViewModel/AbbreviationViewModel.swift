//
//  AbbreviationViewModel.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import Foundation

protocol AbbreviationViewModelProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    var AbbreviationModel: [AbbreviationModel] { get set }
    var completion: (([AbbreviationModel]?, ServerError) -> Void)? { get set }
    func getAbbreviation(sf: String, lf: String)
}

final class AbbreviationViewModel: AbbreviationViewModelProtocol {

    // MARK: - Variables
    var AbbreviationModel: [AbbreviationModel] = []
    var networkService: NetworkServiceProtocol
    var completion: (([AbbreviationModel]?, ServerError) -> Void)?

    // MARK: - Init
    init(AbbreviationModel: [AbbreviationModel] = [],
         networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.AbbreviationModel = AbbreviationModel
        self.networkService = networkService
    }

    // MARK: - Methods

    /// Get data from cloud server
    func getAbbreviation(sf: String, lf: String = "") {
        if !sf.isEmpty {
            let param = RequestModel.AbbreviationInfo(sf: sf, lf: lf)
            Task {
                let result = await networkService.getAbbreviation(param: param)
                switch result {
                case .success(let model):
                    if let model {
                        self.AbbreviationModel = model

                        /// Send result to view with the help of completion block
                        if model.isEmpty {
                            completion?(model, ServerError.emptyData)
                        } else {
                            completion?(model, ServerError.none)
                        }
                    }
                case .failure(let error):
                    completion?(nil, error)
                }
            }
        }
    }
}
