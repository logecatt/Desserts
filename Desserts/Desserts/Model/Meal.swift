//
//  Meal.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

struct MealResponseWrapper: Codable {
    let meals: Array<Meal>?
}

struct Meal: Identifiable {
    let id: String
    let name: String
    let thumbnailURL: String?
    var details: MealDetail?
}

extension Meal: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}

extension Meal {
    static let sampleData: Array<Meal> = [
        Meal(id: "1", name: "Apple Pie", thumbnailURL: nil),
        Meal(id: "2", name: "Red Velvet Cake", thumbnailURL: nil),
        Meal(id: "3", name: "Pineapple Upside-Down Cake", thumbnailURL: nil)
    ]
}
