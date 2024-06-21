//
//  Meal.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

// MARK: Wrapper

struct MealResponseWrapper: Codable {
    let meals: Array<Meal>?
}

// MARK: Type Definition

/// A type that describes a Meal
///
/// - Parameters:
///     - id: The unique identifier of the Meal.
///     - name: The name of the Meal.
///     - thumbnailURL: The String representation of the Meal's thumbnail image, otherwise `nil`.
///     - details: The details associated with the Meal.
struct Meal: Identifiable {
    let id: String
    let name: String
    let thumbnailURL: String?
    var details: MealDetail?
}

// MARK: CodingKeys

extension Meal: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}

// MARK: Mock Data
extension Meal {
    static let sampleData: Array<Meal> = [
        Meal(id: "1", name: "Apple Pie", thumbnailURL: nil),
        Meal(id: "2", name: "Red Velvet Cake", thumbnailURL: nil),
        Meal(id: "3", name: "Pineapple Upside-Down Cake", thumbnailURL: nil)
    ]
}
