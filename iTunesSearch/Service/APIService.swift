//
//  APIService.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 20.01.2021.
//

import Foundation
import Alamofire

class APIService: NSObject {
    
    func getSearch(termValue:String?,
                     entityValue:String?,
                     offsetValue:Int,
                     limit:Int,
                     completion:@escaping (DataResponse<BaseResult, AFError>) -> Void) {

        AF.request("\(Constant.baseUrl)\(Constant.term)\(termValue ?? "")\(Constant.entity)\(entityValue ?? "")\(Constant.offset)\(offsetValue)\(Constant.limit)\(limit)").validate().responseDecodable(of: BaseResult.self) { response in
            completion(response)
        }
    }
}
