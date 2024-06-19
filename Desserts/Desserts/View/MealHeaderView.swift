//
//  MealHeaderView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/19/24.
//

import SwiftUI

struct MealHeaderView: View {
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: meal.thumbnailURL ?? ""), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                
            }, placeholder: {
                
            })
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            Text(meal.name.localizedCapitalized)
                .font(.largeTitle)
                .bold()
        }
    }
}

#Preview {
    MealHeaderView(meal: Meal.sampleData[0])
}
