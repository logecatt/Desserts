//
//  DessertsApp.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/13/24.
//

import SwiftUI

@main
struct DessertsApp: App {
    @State private var meals: [Meal] = []
    var body: some Scene {
        WindowGroup {
            MealsView(meals: $meals)
        }
    }
}
