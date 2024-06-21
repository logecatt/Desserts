//
//  MealsView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

struct MealsView: View {
    @Binding var meals: [Meal]
    @State private var searchText: String = ""
    
    private struct Constants {
        static let columnMinimumWidth = 170.0
        static let columnSpacing = 16.0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: Constants.columnMinimumWidth))],
                    alignment: .center,
                    spacing: Constants.columnSpacing
                ) {
                    ForEach($filteredMeals) { $meal in
                        NavigationLink(destination: MealDetailView(meal: $meal)) {
                            MealCardView(meal: meal)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.never)
            .navigationTitle("Dessert")
        }
        .searchable(text: $searchText, prompt: "Filter meals by name")
        .onAppear {
            Task {
                do {
                    meals = try await MealClient().getMealsForCategory() ?? []
                    updateFilteredMeals(searchText)
                } catch {
                    meals = []
                }
            }
        }
        .onChange(of: searchText) {
            updateFilteredMeals(searchText)
        }
    }
    
    @State private var filteredMeals: [Meal] = []
    
    func updateFilteredMeals(_ searchText: String) {
        if searchText.isEmpty {
            filteredMeals = meals
        } else {
            filteredMeals = meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

#Preview {
    MealsView(meals: .constant(Meal.sampleData))
}
