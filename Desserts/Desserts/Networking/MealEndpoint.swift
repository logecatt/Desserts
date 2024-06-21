//
//  MealEndpoint.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/20/24.
//

import Foundation

/// Enumeration that defines the different endpoints in the Meals API.
enum MealEndpoint: APIEndpoint {
    case getMeals(category: String)
    case getMealDetails(id: String)
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "www.themealdb.com/api/json/v1/1"
    }
    
    var path: String {
        switch self {
        case .getMeals:
            return "/filter.php"
        case .getMealDetails:
            return "/lookup.php"
        }
    }
    
    var method: RequestType {
        switch self {
        case .getMeals, .getMealDetails:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var urlParams: [URLQueryItem]? {
        switch self {
        case .getMeals(let category):
            return [URLQueryItem(name: "c", value: category)]
        case .getMealDetails(let id):
            return [URLQueryItem(name: "i", value: id)]
        }
    }
}
