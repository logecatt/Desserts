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
                        Text(meal.name)
                    }
                }
                .padding()
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
