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
    
    @State private var isEditingSection1 = false
    @State private var isEditingSection2 = false
    @State private var isEditingSection3 = false
    
    private var isEditingOn: Bool {
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
                Section(header: EditingButton(isEditing: $isEditingSection1).frame(maxWidth: .infinity, alignment: .trailing)
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
                        ForEach(instructions) { instruction in
                            let index = instructions.firstIndex(of: instruction) ?? 0
                            TextField("Step \(index + 1)", text: $instructions[index].content)
                        }
                        .onDelete(perform: { indexSet in
                            instructions.remove(atOffsets: indexSet)
                        })
                        .onMove(perform: { indices, newOffset in
                            instructions.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .deleteDisabled(!isEditingSection1)
                        .moveDisabled(!isEditingSection1)
                    }
                    if isEditingSection1 {
                        Button {
                            withAnimation {
                                instructions.append(IteratableString(content: ""))
                            }
                        } label: {
                            Text("Add Step")
                        }
                    }
                }
                Section(header: EditingButton(isEditing: $isEditingSection2).frame(maxWidth: .infinity, alignment: .trailing)
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
                        ForEach(ingredients) { ingredient in
                            let index = ingredients.firstIndex(of: ingredient) ?? 0
                            TextField("Ingredient \(index + 1)", text: $ingredients[index].content)
                        }
                        .onDelete(perform: { indexSet in
                            ingredients.remove(atOffsets: indexSet)
                        })
                        .onMove(perform: { indices, newOffset in
                            ingredients.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .deleteDisabled(!isEditingSection2)
                        .moveDisabled(!isEditingSection2)
                    }
                    if isEditingSection2 {
                        Button {
                            ingredients.append(IteratableString(content: ""))
                        } label: {
                            Text("Add Ingredient")
                        }
                    }
                }
                Section(header: EditingButton(isEditing: $isEditingSection3).frame(maxWidth: .infinity, alignment: .trailing)
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
                        ForEach(recipeCategories) { recipeCategory in
                            let index = recipeCategories.firstIndex(of: recipeCategory) ?? 0
                            TextField("Step \(index + 1)", text: $recipeCategories[index].content)
                        }
                        .onDelete(perform: { indexSet in
                            recipeCategories.remove(atOffsets: indexSet)
                        })
                        .onMove(perform: { indices, newOffset in
                            recipeCategories.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .deleteDisabled(!isEditingSection3)
                        .moveDisabled(!isEditingSection3)
                    }
                    if isEditingSection3 {
                        Button {
                            recipeCategories.append(IteratableString(content: ""))
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
