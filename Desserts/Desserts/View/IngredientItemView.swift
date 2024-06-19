//
//  IngredientItemView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/19/24.
//

import SwiftUI

struct IngredientItemView: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text("•")
            Text("\(ingredient.measurement.localizedLowercase)")
                .fontWeight(ingredient.measurement.contains { $0.isNumber } ? .bold : .regular) + Text(" \(ingredient.name.localizedLowercase)")
        }
    }
}

#Preview {
    IngredientItemView(ingredient: Ingredient(name: "flour", measurement: "2 cups"))
}
