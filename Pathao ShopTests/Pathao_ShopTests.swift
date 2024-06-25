//
//  Pathao_ShopTests.swift
//  Pathao ShopTests
//
//  Created by Md Faizul karim on 14/9/23.
//

import XCTest
@testable import Pathao_Shop

final class Pathao_ShopTests: XCTestCase {
    var router: HomeViewRouter!
    var viewModel: HomeViewViewModelType!


    override  func setUp() {
        super.setUp()
        self.router = HomeViewRouter(dependencyManager: OTDependencyManager.defaultValue)
        
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShopApi() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    
        let router = HomeViewRouter(dependencyManager: OTDependencyManager.defaultValue)
      
        let viewModel = HomeViewViewModel(apiManager: OTAPIManager())
        let params: Parameters = ["results": "20"]
        let controller = HomeViewViewController(analyticsManager: DefaultAnalyticsManager(), theme: OTDependencyManager().theme(), viewModel: viewModel, router: router)
         controller.shopApiSubject.send(params)
        print(controller.displayModel.shopResponse)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
