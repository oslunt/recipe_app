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
    @State private var instructions: [String] = []
    @State private var ingredients: [String] = []
    @State private var recipeCategories: [String] = []
    @State private var favorite: Bool = false
    var recipe: Item?
    
    @State private var isEditingSection1 = false
    @State private var isEditingSection2 = false
    @State private var isEditingSection3 = false
    
    private var isEditingOn: Bool { //<=== Here
        isEditingSection1 || isEditingSection2 || isEditingSection3
    }
    
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
                Section(header: EditingButton(isEditing: $isEditingSection1).frame(maxWidth: .infinity, alignment: .trailing) //<=== Here
                    .overlay(
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(Color.gray)
                        Text("Instructions")
                            .textCase(.none)
                            .foregroundColor(Color.gray)
                        }, alignment: .leading)
                    .foregroundColor(.blue)) {
                    List {
                        ForEach(instructions.indices, id: \.self) { index in
                            TextField("Step \(index + 1)", text: $instructions[index])
                        }
                        .onDelete(perform: { indexSet in
                            instructions.remove(atOffsets: indexSet)
                        })
                        .deleteDisabled(!isEditingSection1)
                    }
                    if isEditingSection1 {
                        Button {
                            withAnimation {
                                instructions.append("")
                            }
                        } label: {
                            Text("Add Step")
                        }
                    }
                }
                Section(header: EditingButton(isEditing: $isEditingSection2).frame(maxWidth: .infinity, alignment: .trailing) //<=== Here
                    .overlay(
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(Color.gray)
                        Text("Ingredients")
                            .textCase(.none)
                            .foregroundColor(Color.gray)
                        }, alignment: .leading)
                    .foregroundColor(.blue)) {
                    List {
                        ForEach(ingredients.indices, id: \.self) { index in
                            TextField("Ingredient \(index + 1)", text: $ingredients[index])
                        }
                        .onDelete(perform: { indexSet in
                            ingredients.remove(atOffsets: indexSet)
                        })
                        .deleteDisabled(!isEditingSection2)
                    }
                    if isEditingSection2 {
                        Button {
                            ingredients.append("")
                        } label: {
                            Text("Add Ingredient")
                        }
                    }
                }
                Section(header: EditingButton(isEditing: $isEditingSection3).frame(maxWidth: .infinity, alignment: .trailing) //<=== Here
                    .overlay(
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(Color.gray)
                        Text("Recipe Categories")
                            .textCase(.none)
                            .foregroundColor(Color.gray)
                        }, alignment: .leading)
                    .foregroundColor(.blue)) {
                    List {
                        ForEach(recipeCategories.indices, id: \.self) { index in
                            TextField("Category \(index + 1)", text: $recipeCategories[index])
                        }
                        .onDelete(perform: { indexSet in
                            recipeCategories.remove(atOffsets: indexSet)
                        })
                        .deleteDisabled(!isEditingSection3)
                    }
                    if isEditingSection3 {
                        Button {
                            recipeCategories.append("")
                        } label: {
                            Text("Add Category")
                        }
                    }
                }
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
            .environment(\.editMode, isEditingOn ? .constant(.active) : .constant(.inactive))
        }
    }
    
    private func deleteInstruction(indexSet: IndexSet) {
        withAnimation {
            instructions.remove(atOffsets: indexSet)
        }
    }
    
    private func deleteIngredient(indexSet: IndexSet) {
        withAnimation {
            ingredients.remove(atOffsets: indexSet)
        }
    }

    private func deleteRecipeCategory(indexSet: IndexSet) {
        withAnimation {
            recipeCategories.remove(atOffsets: indexSet)
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

struct EditingButton: View {
    @Binding var isEditing: Bool

    var body: some View {
        Button(isEditing ? "DONE" : "EDIT") {
            withAnimation {
                isEditing.toggle()
            }
        }
    }
}
