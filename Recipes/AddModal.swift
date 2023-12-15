//
//  AddModal.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/1/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct AddModal: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var timeRequired = ""
    @State private var servings = ""
    @State private var expertise = ""
    @State private var calories = ""
    @State private var instructions: [IteratableString] = []
    @State private var ingredients: [IteratableString] = []
    @State private var recipeCategories: [IteratableString] = []
    @State private var favorite: Bool = false
    var recipe: Item?
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Time Required", text: $timeRequired)
                    TextField("Servings", text: $servings)
                    TextField("Expertise", text: $expertise)
                    TextField("Calories", text: $calories)
                }
                
                AddModalArraySection(recipeItemArray: $instructions, title: "Instructions", singularType: "Step")
                AddModalArraySection(recipeItemArray: $ingredients, title: "Ingredients", singularType: "Ingredient")
                AddModalArraySection(recipeItemArray: $recipeCategories, title: "Categories", singularType: "Category")
                
                Toggle("Favorite", isOn: $favorite)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled($title.wrappedValue.count == 0 || $instructions.isEmpty || $ingredients.isEmpty)
                }
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let recipe {
                    title = recipe.title
                    author = recipe.author ?? ""
                    timeRequired = recipe.timeRequired ?? ""
                    servings = recipe.servings ?? ""
                    expertise = recipe.expertise ?? ""
                    calories = recipe.calories ?? ""
                    instructions = recipe.instructions
                    ingredients = recipe.ingredients
                    recipeCategories = recipe.recipeCategories
                    favorite = recipe.favorite
                }
            }
        }
    }
    
    private func save() {
        if let recipe {
            recipe.title = title
            recipe.author = author
            recipe.timeRequired = timeRequired
            recipe.servings = servings
            recipe.expertise = expertise
            recipe.calories = calories
            recipe.instructions = instructions
            recipe.ingredients = ingredients
            recipe.recipeCategories = recipeCategories
            recipe.favorite = favorite
        } else {
            let newItem = Item(title: title, ingredients: ingredients, instructions: instructions, author: author, timeRequired: timeRequired, servings: servings, expertise: expertise, calories: calories, recipeCategories: recipeCategories, favorite: favorite)
            modelContext.insert(newItem)
        }
    }
}
