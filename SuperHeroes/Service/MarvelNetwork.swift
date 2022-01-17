//
//  MarvelNetwork.swift
//  Marvel
//
//  Created by Alper  Kurt on 16.01.2022.
//  Copyright © 2022 Alper  Kurt. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import ObjectMapper
import Alamofire

struct MarvelNetwork {

    @discardableResult static public func makeRequest(
        target: MarvelAPIService,
        success successWithJSON: @escaping (JSON) -> Void,
        statusCode statusCodeWithDetail: @escaping (_ statusCode: Int, _ message: String, _ formErrors: [String: [String]]?) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) -> Cancellable {
//        var pluginArray: [PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let pluginArray: [PluginType] = [NetworkLoggerPlugin()]
//        let accessTokenPlugin = AccessTokenPlugin(tokenClosure: {_ in (BeinConnectAPIManager.shared.token ?? "") })   

        
//        pluginArray.append(accessTokenPlugin)
        
        
        let provider = MoyaProvider<MarvelAPIService>(plugins: pluginArray)
        
        
        return provider.request(target, completion: {  result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    
                    successWithJSON(json)
                } catch MoyaError.statusCode(let errorResponse) {
                    do {
                        let errorJSON = try JSON(response.mapJSON())
                        if let errorString = errorJSON["message"].string {
                            if let formErrors = errorJSON["errors"].dictionaryObject {
                                statusCodeWithDetail(errorResponse.statusCode, errorString, formErrors as? [String: [String]])
                            } else {
                                statusCodeWithDetail(errorResponse.statusCode, errorString, nil)
                            }
                        }
                        
                    } catch {
                        statusCodeWithDetail(errorResponse.statusCode, errorResponse.description, nil)
                    }
                } catch MoyaError.jsonMapping(let response) {
                    let statusCode = response.statusCode
                    if let response: HTTPURLResponse = response.response{
                        print("responseStatusNetwork : \(response)")
                        statusCodeWithDetail(statusCode, "", nil)
                        return
                    }
                    statusCodeWithDetail(statusCode, "", nil)
                }  catch {
                    statusCodeWithDetail(0, "error", nil)
                }
                
            case let .failure(error):
                failureCallback(error)
            }
        })
    }
}
