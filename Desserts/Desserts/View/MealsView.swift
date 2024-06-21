//
//  MealsView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

struct MealsView: View {
    let category: String = "Dessert"
    @Binding var meals: [Meal]
    @State private var filteredMeals: [Meal] = []
    @State private var searchText: String = ""
    @State private var contentViewState: ContentViewState = .loading
    
    private struct Constants {
        static let columnMinimumWidth = 170.0
        static let columnSpacing = 16.0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                switch contentViewState {
                case .loading:
                    loadingView
                case .success:
                    contentView
                case .failure:
                    errorView
                }
            }
            .scrollIndicators(.never)
            .navigationTitle(category)
        }
        .searchable(text: $searchText, prompt: "Filter meals by name")
        .onAppear {
            Task {
                do {
                    contentViewState = .loading
                    meals = try await MealClient().getMealsForCategory(category: category) ?? []
                    updateFilteredMeals(searchText)
                    contentViewState = .success
                } catch {
                    meals = []
                    contentViewState = .failure
                }
            }
        }
        .onChange(of: searchText) {
            updateFilteredMeals(searchText)
        }
    }
        
    func updateFilteredMeals(_ searchText: String) {
        if searchText.isEmpty {
            filteredMeals = meals
        } else {
            filteredMeals = meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var loadingView: some View {
        ProgressView()
    }
    
    var contentView: some View {
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
    
    var errorView: some View {
        Text("Oops! An error occurred. Please try again later.")
    }
}

#Preview {
    MealsView(meals: .constant(Meal.sampleData))
}
