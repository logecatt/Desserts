//
//  MealClient.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

/// A client used to make requests to the Meals API.
struct MealClient {
    
    /// Requests a list of meals for a given category.
    /// - Parameter category: The category of meals being fetched. The default value is "Dessert".
    /// - Returns: An array of `Meal` objects.
    func getMealsForCategory(category: String = "Dessert") async throws -> Array<Meal>? {
        do {
            let endpoint = MealEndpoint.getMeals(category: category)
            let response: MealResponseWrapper = try await NetworkManager.shared.request(from: endpoint)
            return response.meals?.sorted(by: { $0.name < $1.name })
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// Requests the meal details for a given meal.
    /// - Parameter id: The meal id.
    /// - Returns: A `MealDetail` object containing the details of the given meal.
    func getMealDetails(id: String) async throws -> MealDetail? {
        do {
            let endpoint = MealEndpoint.getMealDetails(id: id)
            let response: MealDetailResponseWrapper = try await NetworkManager.shared.request(from: endpoint)
            return response.meals?.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
