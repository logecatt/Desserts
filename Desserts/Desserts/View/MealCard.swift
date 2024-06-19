//
//  MealCard.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/19/24.
//

import SwiftUI

struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            AsyncImage(
                url: URL(string: meal.thumbnailURL ?? ""),
                content: { image in
                    image.resizable()
                }, placeholder: {
                    Image(systemName: "birthday.cake")
                        .padding()
                }
            )
            .aspectRatio(contentMode: ContentMode.fill)
            .frame(width: 170, height: 170)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            Text(meal.name.localizedCapitalized)
                .font(.caption)
        }
    }
}

#Preview("", traits: .sizeThatFitsLayout) {
    MealCard(meal: Meal.sampleData[0])
}
