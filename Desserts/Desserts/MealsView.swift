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
    
    var body: some View {
        NavigationStack {
            List($filteredMeals) { $meal in
                NavigationLink(destination: MealDetailView(meal: $meal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnailURL ?? ""), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            Image(systemName: "birthday.cake")
                                .resizable()
                                .background(Color.pink)
                        })
                        .frame(width: 70, height: 70)
                        Text(meal.name)
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
            .navigationTitle("Dessert")
        }
        .searchable(text: $searchText, prompt: "Search for a meal by name")
        .onAppear {
            Task {
                do {
                    meals = try await MenuClient().getMealsForCategory() ?? []
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
            filteredMeals = meals.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    MealsView(meals: .constant(Meal.sampleData))
}
