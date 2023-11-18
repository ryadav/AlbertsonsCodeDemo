//
//  MockNetworkServiceLayer.swift
//  AlbertsonCodeDemoTests
//
//  Created by Apple  on 18/11/23.
//

import XCTest
@testable import AlbertsonCodeDemo

final class MockNetworkServiceLayer: NetworkServiceProtocol {
    var getAcromineCalled = false
    var successResult = true
    var expectations: XCTestExpectation?
    
    func getAcromine(param: Encodable) async -> Result<[AcromineModel]?, ServerError> {
        getAcromineCalled = true
        expectations?.fulfill()
        
        if successResult {
            return .success([AcromineModel(sf: "APP", lfs: nil)])
        }
        
        return .failure(ServerError.networkRespose)
    }
}
