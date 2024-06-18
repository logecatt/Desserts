//
//  MealDetailView.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

struct MealDetailView: View {
    @Binding var meal: Meal
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                mealHeaderView
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(meal.name)
                            .font(.title)
                        
                        mealIngredientsView
                        
                        mealInstructionsView
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            if meal.details == nil {
                isLoading = true
                Task {
                    do {
                        meal.details = try await MenuClient().getMealDetails(id: meal.id)
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
    var mealHeaderView: some View {
        if let imageURL = meal.thumbnailURL {
            AsyncImage(url: URL(string: imageURL), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .mask(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .top, endPoint: .bottom
                    ))
            }, placeholder: {
                EmptyView()
            }
            )
            .frame(maxHeight: 200)
            .ignoresSafeArea(edges: .top)
            .frame(maxHeight: 200)
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
                    Text("• \(ingredient.measurement) \(ingredient.name)"
                    )
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
