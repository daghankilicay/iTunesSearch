//
//  SearchViewModelTest.swift
//  iTunesSearchTests
//
//  Created by Dağhan Kılıçay on 22.01.2021.
//

import XCTest
@testable import iTunesSearch
import Alamofire

class SearchViewModelTest: XCTestCase {
    
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
