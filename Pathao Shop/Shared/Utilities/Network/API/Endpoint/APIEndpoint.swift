//
//  APIEndpoint.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//


import Foundation


public enum APIEndpoint {
    
    case getShop(params: Parameters)
    
    
}
extension APIEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return Constants.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getShop:
            return "api"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getShop:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getShop(let params):
            print(params)
          return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self  {
        case .getShop:
            return nil
        }
    }
    
}
