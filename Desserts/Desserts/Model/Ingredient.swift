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
    /// The ingredient ID.
    let id: Int
    /// The ingredient name.
    let name: String
    /// The ingredient measurement.
    let measurement: String
    
    /// <#Description#>
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - name: <#name description#>
    ///   - measurement: <#measurement description#>
    init(id: Int = 0, name: String, measurement: String) {
        self.id = id
        self.name = name
        self.measurement = measurement
    }
}
