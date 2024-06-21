//
//  MealDetail.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

// MARK: Wrapper

struct MealDetailResponseWrapper: Decodable {
    let meals: Array<MealDetail>?
}

// MARK: Type Definition

/// A type that contains the details of a meal.
struct MealDetail: Identifiable {
    /// The unique meal ID.
    let id: String
    /// The meal category.
    let category: String
    /// The meal instructions.
    let instructions: String
    /// An array of ingredients and their measurements for the meal.
    var ingredients: Array<Ingredient>?
}

// MARK: Decoding

extension MealDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case category = "strCategory"
        case instructions = "strInstructions"
    }
    
    // This type is needed to dynamically decode the ingredients and measurements
    // from the response, rather than individually defining each of the 20
    // possible ingredients and measurements in the model.
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        
        self.category = try values.decode(String.self, forKey: .category)
        self.instructions = try values.decode(String.self, forKey: .instructions)
        ingredients = []
         
        do {
            var rawIngredients: Array<(Int, String)> = []
            var rawMeasures: Array<(Int, String)> = []
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            
            // Iterate through all keys in the response, pulling out values
            // associated with ingredient and measurement keys.
            for key in container.allKeys {
                if key.stringValue.hasPrefix("strIngredient") {
                    let newIngredient = try container.decodeIfPresent(
                        String.self,
                        forKey: DynamicCodingKeys(stringValue: key.stringValue)!
                    )
                    if let newIngredient = newIngredient,
                       !newIngredient.replacingOccurrences(of: " ", with: "").isEmpty {
                        rawIngredients.append((key.stringValue.extractInt() ?? 1, newIngredient))
                    }
                } else if key.stringValue.hasPrefix("strMeasure") {
                    let newMeasure = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                    if let newMeasure = newMeasure,
                       !newMeasure.replacingOccurrences(of: " ", with: "").isEmpty {
                        rawMeasures.append((key.stringValue.extractInt() ?? 1, newMeasure))
                    }
                }
            }
            
            // Reorder the ingredients and measurements since they may not
            // be parsed in order
            rawIngredients.sort(by: { $0.0 < $1.0})
            rawMeasures.sort(by: { $0.0 < $1.0 })
            
            var ingredients: Array<Ingredient> = []
            for index in 0..<min(rawIngredients.count, rawMeasures.count) {
                ingredients.append(Ingredient(
                    id: index,
                    name: rawIngredients[index].1,
                    measurement: rawMeasures[index].1)
                )
            }
            
            self.ingredients = ingredients
        } catch {
            throw NetworkError.parsingError
        }
    }
}

// MARK: Mock Data

extension MealDetail {
    static let sampleData = MealDetail(id: "1", category: "Dessert", instructions: "Bake the pie", ingredients: [
        Ingredient(id: 0, name: "crust", measurement: "1"),
        Ingredient(id: 1, name: "apples, chopped", measurement: "1 lb"),
        Ingredient(id: 2, name: "cinnamon", measurement: "1 1/2 tsp")
    ]
    )
}
