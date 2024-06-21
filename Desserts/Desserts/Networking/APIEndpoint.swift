//
//  APIEndpoint.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/20/24.
//

import Foundation

/// A protocol for defining API endpoints.
protocol APIEndpoint {
    /// The scheme subcomponent of the endpoint URL.
    var scheme: String { get }
    
    /// The base URL of the endpoint.
    var baseURL: String { get }
    /// The path subcomponent of the endpoint.
    var path: String { get }
    
    /// The headers needed to make a request at the endpoint.
    var headers: [String: String]? { get }
    
    /// An array of query items appended to the endpoint URL.
    var urlParams: [URLQueryItem]? { get }
    
    /// The HTTP request method.
    var method: RequestType { get }
}
