//
//  MealCardView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/19/24.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    
    private struct Constants {
        static let spacing = 8.0
        static let imageSize = 170.0
        static let cornerRadius = 8.0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
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
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            Text(meal.name.localizedCapitalized)
                .font(.caption)
        }
    }
}

#Preview("", traits: .sizeThatFitsLayout) {
    MealCardView(meal: Meal.sampleData[0])
}
