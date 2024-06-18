//
//  MealDetail.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import Foundation

struct MealDetailWrapper: Decodable {
    let meals: Array<MealDetail>?
}

struct MealDetail: Identifiable {
    let id: String
    let category: String // TODO: Change this to Category enum
    let instructions: String
    var ingredients: Array<Ingredient>?
}

extension MealDetail: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        
        self.category = try values.decode(String.self, forKey: .category)
        self.instructions = try values.decode(String.self, forKey: .instructions)
        ingredients = []
            
        do {
            var rawIngredients: Array<(String, String)> = []
            var rawMeasures: Array<(String, String)> = []
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            for key in container.allKeys {
                if key.stringValue.hasPrefix("strIngredient") {
                    let newIngredient = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                    if let newIngredient = newIngredient, !newIngredient.isEmpty {
                        rawIngredients.append((key.stringValue, newIngredient))
                    }
                } else if key.stringValue.hasPrefix("strMeasure") {
                    let newMeasure = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                    if let newMeasure = newMeasure, !newMeasure.isEmpty {
                        rawMeasures.append((key.stringValue, newMeasure))
                    }
                }
            }
            
            rawIngredients.sort(by: { $0.0 < $1.0})
            rawMeasures.sort(by: { $0.0 < $1.0 })
            
            var ingredients: Array<Ingredient> = []
            for index in 0..<min(rawIngredients.count, rawMeasures.count) {
                ingredients.append(Ingredient(name: rawIngredients[index].1, measurement: rawMeasures[index].1))
            }
            
            self.ingredients = ingredients
        } catch {
            print(error)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case category = "strCategory"
        case instructions = "strInstructions"
    }
    
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
}

struct Ingredient {
    let name: String
    let measurement: String
}
