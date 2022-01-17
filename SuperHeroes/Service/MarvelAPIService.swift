//
//  MarvelAPIService.swift
//  Marvel
//
//  Created by Alper  Kurt on 16.01.2022.
//  Copyright © 2022 Alper  Kurt. All rights reserved.
//

import Foundation
import Moya


enum MarvelAPIService {
    case marvelChar(apiKey: String?, timeStamp: String?, hashKey: String?)
}

extension MarvelAPIService: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }

    var path: String {
        switch self {
        case .marvelChar:
            return "public/characters"
        }
    }
    
    
    var parameters: [String : Any]? {
        
        switch self {
        case .marvelChar(let apiKey, let timeStamp, let hashKey):
            var parameters: [String: Any] = [:]
            if let apiKey = apiKey { parameters["apikey"] = apiKey }
            if let timeStamp = timeStamp { parameters["ts"] = timeStamp }
            if let hashKey = hashKey { parameters["hash"] = hashKey }
            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .marvelChar:
            return .get
//        case .xxx :
//            return .put
//        case .xxx :
//            return .delete
//        default:
//            return .post
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return self.method == .get ? URLEncoding.queryString : JSONEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }
    
    var shouldAuthorize: Bool {
        return true
    }
    
    var sampleData: Data {
        let a = ""
        return a.data(using: .utf8)!
    }
}
