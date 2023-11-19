//
//  AbbreviationViewModelTests.swift
//  AlbertsonCodeDemoTests
//
//  Created by Apple  on 18/11/23.
//

import XCTest
@testable import AlbertsonCodeDemo

final class AbbreviationViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAcronymData_Success() {
        // Arrange
        let mockNetworkService = MockNetworkServiceLayer()
        let homeViewModel = AbbreviationViewModel(networkService: mockNetworkService)

        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "ViewModel test success")
        mockNetworkService.expectations = expectation

        // Act
        homeViewModel.getAbbreviation(sf: "APP")
        wait(for: [expectation], timeout: 10.0)

        // Assert
        XCTAssertTrue(mockNetworkService.getAbbreviationCalled)
        XCTAssertNotNil(homeViewModel.AbbreviationModel)
        XCTAssertTrue(homeViewModel.AbbreviationModel.count > 0)
    }

    func testAcronymData_Failure() {
        // Arrange
        let mockNetworkService = MockNetworkServiceLayer()
        mockNetworkService.successResult = false
        let homeViewModel = AbbreviationViewModel(networkService: mockNetworkService)

        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "ViewModel test failure")
        mockNetworkService.expectations = expectation

        // Act
        homeViewModel.getAbbreviation(sf: "A")
        wait(for: [expectation], timeout: 10.0)

        // Assert
        XCTAssertTrue(mockNetworkService.getAbbreviationCalled)
        XCTAssertTrue(homeViewModel.AbbreviationModel.isEmpty)
    }

}
