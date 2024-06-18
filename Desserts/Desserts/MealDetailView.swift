//
//  MealDetailView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

struct MealDetailView: View {
    @Binding var meal: Meal
    var body: some View {
        NavigationView {
            VStack {
                Text(meal.name)
                
            }
            .navigationTitle(meal.name)
        }
        .onAppear {
            Task {
                do {
                    meal.details = try await MenuClient().getMealDetails(id: meal.id)
                } catch {
                    meal.details = nil
                }
            }
        }
    }
}

#Preview {
    MealDetailView(meal: .constant(Meal.sampleData[0]))
}
