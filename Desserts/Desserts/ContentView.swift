//
//  ContentView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var meals: [Meal]
    var body: some View {
        NavigationView {
            List($meals) { $meal in
                NavigationLink(destination: MealDetailView(meal: $meal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnailURL ?? ""), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            Image(systemName: "birthday.cake")
                        })
                        .frame(width: 70, height: 70)
                        Text(meal.name)
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    meals = try await MenuClient().getMealsForCategory() ?? []
                } catch {
                    meals = []
                }
            }
        }
    }
}

#Preview {
    ContentView(meals: .constant(Meal.sampleData))
}
