//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 20.01.2021.
//

import Foundation

class SearchViewModel: NSObject {
    
    private var apiService : APIService!
    
    init(apiService: APIService = APIService()){
        self.apiService = apiService
    }
    
    private(set) var baseResult : BaseResult! {
        didSet {
            if self.bindCountryViewModelToController != nil{
                self.bindCountryViewModelToController!(self.baseResult)
            }
        }
    }
    
    private(set) var error : Error! {
        didSet {
            if self.bindErrorToController != nil{
                self.bindErrorToController!(error)
            }
        }
    }
    
    var bindCountryViewModelToController : ((BaseResult) -> ())?
    var bindErrorToController : ((Error?) -> ())?
    
    func callFuncToGetEmpData(termValue: String?, entityValue: String?, offsetValue: Int, limit: Int) {
        self.apiService.getSearch(termValue: termValue, entityValue: entityValue, offsetValue: offsetValue, limit: limit) { (response) in
            if response.error == nil{
                self.baseResult = response.value
            }else{
                self.error = response.error
            }
            
        }
    }
}
