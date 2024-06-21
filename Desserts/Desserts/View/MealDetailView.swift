//
//  MealDetailView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

/// A view that displays the details for a specific meal.
struct MealDetailView: View {
    @Binding var meal: Meal
    @State private var isLoading: Bool = false
    @State private var selectedSection: Section = .ingredients
    @Environment(\.dismiss) var dismiss
    
    enum Section: String, CaseIterable, Identifiable {
        case ingredients = "Ingredients"
        case instructions = "Instructions"
        
        var id: Self { self }
    }
    
    var body: some View {
        List {
            MealHeaderView(meal: meal)
                .listRowSeparator(.hidden)
            
            
            SectionPicker(selection: $selectedSection, items: .constant(Section.allCases)) { section in
                    Text(section.rawValue)
            }
            .listRowSeparator(.hidden)
            
            switch selectedSection {
            case .ingredients:
                SectionView(title: LocalizedStringKey(selectedSection.rawValue)) {
                    ForEach(meal.details?.ingredients ?? []) { ingredient in
                        IngredientItemView(ingredient: ingredient)
                    }
                }
                    .listRowSeparator(.hidden)
            case .instructions:
                SectionView(title: LocalizedStringKey(selectedSection.rawValue)) {
                    Text(meal.details?.instructions ?? "")
                }
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.never)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if meal.details == nil {
                isLoading = true
                Task {
                    do {
                        meal.details = try await MealClient().getMealDetails(id: meal.id)
                        isLoading = false
                    } catch {
                        meal.details = nil
                        isLoading = false
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var mealIngredientsView: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title2)
            
            if isLoading {
                ProgressView()
            } else {
                ForEach(meal.details?.ingredients ?? []) { ingredient in
                    IngredientItemView(ingredient: ingredient)
                }
            }
        }
    }
    
    @ViewBuilder
    var mealInstructionsView: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.title2)
            
            if isLoading {
                ProgressView()
            } else {
                    Text(meal.details?.instructions ?? "")
            }
        }
    }
}

#Preview {
    var meal = Meal.sampleData[0]
    meal.details = MealDetail.sampleData
    return MealDetailView(meal: .constant(Meal.sampleData[0]))
}
