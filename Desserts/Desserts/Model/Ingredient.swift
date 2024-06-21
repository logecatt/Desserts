//
//  Ingredient.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/21/24.
//

import Foundation


/// A type that models an ingredient and its associated measurment for a given meal.
///
/// - Parameters:
///     - id: The identifier for the given ingredient in association to its parent meal.
///     - name: The ingredient name.
///     - measurment: The measurement of the ingredient.
struct Ingredient: Identifiable {
    let id: Int
    let name: String
    let measurement: String
    
    init(id: Int = 0, name: String, measurement: String) {
        self.id = id
        self.name = name
        self.measurement = measurement
    }
}
