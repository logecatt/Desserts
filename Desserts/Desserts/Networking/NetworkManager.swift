//
//  NetworkManager.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/21/24.
//

import Foundation

/// A class that manages API calls to an endpoint.
final class NetworkManager {
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    static let shared = NetworkManager()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    /// A generic request function to fetch data from an API endpoint.
    /// - Parameter endpoint: The endpoint being called.
    /// - Returns: The decoded response data from the endpoint.
    func request<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        let request = try createRequest(from: endpoint)
        let response: NetworkResponse = try await session.data(for: request)
        return try decoder.decode(T.self, from: response.data)
    }
}

private extension NetworkManager {
    /// Creates a URLRequest from an APIEndpoint.
    /// - Parameter endpoint: An APIEndpoint object to build a URLRequest from.
    /// - Returns: A URLRequest object constructed from the given endpoint.
    private func createRequest(from endpoint: APIEndpoint) throws -> URLRequest {
        guard let urlPath = URL(string: endpoint.baseURL)?.appendingPathComponent(endpoint.path),
              var urlComponents = URLComponents(string: urlPath.absoluteString) else {
            throw NetworkError.invalidPath
        }
        
        urlComponents.scheme = endpoint.scheme
        
        if let parameters = endpoint.urlParams {
            urlComponents.queryItems = parameters
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
