//
//  RecipesApp.swift
//  Recipes
//
//  Created by IS 543 on 11/27/23.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Item.self])
    }
}
