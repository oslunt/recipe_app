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
    @State private var date = Date()
    @State private var timeRequired = ""
    @State private var servings = ""
    @State private var expertise = ""
    @State private var calories = ""
    @State private var instructions: [String] = []
    @State private var ingredients: [String] = []
    @State private var recipeCategories: [String] = []
    @State private var favorite: Bool = false
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle")
                .foregroundColor(.gray)
        }
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                DatePicker("Date", selection: $date)
                TextField("Time Required", text: $timeRequired)
                TextField("Servings", text: $servings)
                TextField("Expertise", text: $expertise)
                TextField("Calories", text: $calories)
            }
            Section(header: Text("Insructions")) {
                List {
                    ForEach(instructions.indices, id: \.self) { index in
                        TextField("Step \(index + 1)", text: $instructions[index])
                    }
                    .onDelete { indexSet in
                        instructions.remove(atOffsets: indexSet)
                    }
                    Button {
                        instructions.append("")
                    } label: {
                        Text("Add Step")
                    }
                }
            }
            Section(header: Text("Ingredients")) {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        TextField("Step \(index + 1)", text: $ingredients[index])
                    }
                    .onDelete { indexSet in
                        ingredients.remove(atOffsets: indexSet)
                    }
                    Button {
                        ingredients.append("")
                    } label: {
                        Text("Add Ingredient")
                    }
                }
            }
            Section(header: Text("Categories")) {
                List {
                    ForEach(recipeCategories.indices, id: \.self) { index in
                        TextField("Step \(index + 1)", text: $recipeCategories[index])
                    }
                    .onDelete { indexSet in
                        recipeCategories.remove(atOffsets: indexSet)
                    }
                    Button {
                        recipeCategories.append("")
                    } label: {
                        Text("Add Step")
                    }
                }
            }
            Toggle("Favorite", isOn: $favorite)
            Section {
                Button {
                    if !title.isEmpty && !instructions.isEmpty && !ingredients.isEmpty {
                        let newItem = Item(title: title, ingredients: ingredients, instructions: instructions, author: author, date: date, timeRequired: timeRequired, servings: servings, expertise: expertise, calories: calories, recipeCategories: recipeCategories, favorite: favorite)
                        modelContext.insert(newItem)
                        dismiss()
                    } else {
                        Text("Input a title, instructions, and ingredients")
                    }
                } label: {
                    Text("Save Recipe")
                }
            }
        }
    }
        
}
