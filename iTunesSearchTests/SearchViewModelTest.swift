//
//  SearchViewModelTest.swift
//  iTunesSearchTests
//
//  Created by Dağhan Kılıçay on 22.01.2021.
//

import XCTest
@testable import iTunesSearch
@testable import Mocker
import Alamofire

class SearchViewModelTest: XCTestCase {
//
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        self.mockService = MockApiService()
//        searchViewModel = .init(apiService: mockService)
    }
    
    
    func testSearchViewModel() {
        let e = expectation(description: "AF")
        let viewModel = SearchViewModel(apiService: APIService())
        
        viewModel.callFuncToGetEmpData(termValue: "love", entityValue: "movie", offsetValue: 0, limit: 20)
        viewModel.bindCountryViewModelToController = { response -> Void in
            XCTAssertNotNil(response)
            XCTAssertNotNil(response.results)
            XCTAssertTrue(response.results.count > 0)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
