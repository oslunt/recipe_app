//
//  FilteredListView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/4/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct FilteredListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddModal = false
    @Query private var allItems: [Item]
    @State private var searchTerm = ""
    @State private var items: [Item] = []
    private var category: String
    private var filterIsFavorite: Bool
    private var filteredItems: [Item] {
        if searchTerm != "" {
            return items.filter { $0.title.contains(searchTerm) }
        }
        else {
            return items
        }
    }
    
    init(category: String, filterIsFavorite: Bool, items: [Item]) {
        self.category = category
        self.filterIsFavorite = filterIsFavorite
        _items = State(initialValue: items)
    }
    
    var body: some View {
        List {
            ForEach(filteredItems) { item in
                ItemDetailView(item: item)
            }
            .onDelete(perform: deleteItems)
        }
        .searchable(text: $searchTerm)
        .toolbar {
            ToolbarItem {
                EditButton()
            }
            ToolbarItem {
                Button(action: initializeRecipes) {
                    Label("Initialize Recipes", systemImage: "square.and.pencil")
                }
            }
            ToolbarItem {
                Button(action: toggleShowAddModal) {
                    Label("Add Item", systemImage: "plus")
                }
                .sheet(isPresented: $showAddModal, onDismiss: {
                    withAnimation {
                        if category != "" {
                            items = allItems.filter { $0.contains(wherestring: category) }
                        }
                        else if filterIsFavorite {
                            items = allItems.filter { $0.favorite }
                        }
                        else {
                            items = allItems
                        }
                    }
                }) {
                    AddModal()
                }
            }
        }
    }
        
    private func toggleShowAddModal() {
        showAddModal.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        if category != "" {
            withAnimation {
                for index in offsets {
                    let tempItem = Item(title: items[index].title, ingredients: items[index].ingredients, instructions: items[index].instructions, author: items[index].author, timeRequired: items[index].timeRequired, servings: items[index].servings, expertise: items[index].expertise, calories: items[index].calories, recipeCategories: items[index].recipeCategories, favorite: items[index].favorite)
                    tempItem.recipeCategories = []
                    for recipeCategory in tempItem.recipeCategories {
                        if recipeCategory.content != category {
                            tempItem.recipeCategories.append(recipeCategory)
                        }
                    }
                    modelContext.delete(items[index])
                    modelContext.insert(tempItem)
                    items.remove(at: index)
                }
            }
        }
        else {
            withAnimation {
                for index in offsets {
                    modelContext.delete(items[index])
                    items.remove(at: index)
                }
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            if let recipes = loadJson(filename: "SampleData") {
                for recipe in recipes {
                    let newItem = Item(title: recipe.title, ingredients: [IteratableString(content: recipe.ingredients)], instructions: [IteratableString(content: recipe.instructions)], author: "", timeRequired: "", servings: "", expertise: "", calories: "", recipeCategories: [], favorite: false)
                    modelContext.insert(newItem)
                    items.append(newItem)
                }
            }
        }
    }
}
