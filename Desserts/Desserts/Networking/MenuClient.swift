//
//  MenuClient.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

struct MenuClient {
    func getMealsForCategory(category: String = "Dessert") async throws -> Array<Meal>? {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let wrapper = try JSONDecoder().decode(MealResponseWrapper.self, from: data)
        return wrapper.meals
    }
    
    func getMealDetails(id: String) async throws -> MealDetail? {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let wrapper = try JSONDecoder().decode(MealDetailWrapper.self, from: data)
        return wrapper.meals?.first
    }
}
