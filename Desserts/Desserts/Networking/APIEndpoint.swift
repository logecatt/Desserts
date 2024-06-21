//
//  APIEndpoint.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/20/24.
//

import Foundation

protocol APIEndpoint {    
    var scheme: String { get }
    
    var baseURL: String { get }
    var path: String { get }
    
    var headers: [String: String]? { get }
    
    var urlParams: [URLQueryItem]? { get }
    
    var method: RequestType { get }
}
