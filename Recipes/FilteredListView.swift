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
    private var filterCategories: Bool
    private var category: String
    private var filterFavorites: Bool
    @State private var searchTerm = ""
    @Query private var items: [Item]
    private var filteredItems: [Item] {
        if !searchTerm.isEmpty {
            return items.filter { $0.title.contains(searchTerm) }
        } else {
            return items
        }
    }
    
    init(filterCategories: Bool, category: String, filterFavorites: Bool, searchTerm: String = "") {
        self.filterCategories = filterCategories
        self.category = category
        self.filterFavorites = filterFavorites
        self.searchTerm = searchTerm
        _items = Query(filter: #Predicate<Item> { item in
            if filterCategories && category != "" {
                return item.recipeCategories.contains(category)
            }
            else if filterFavorites {
                return item.favorite
            }
            else if searchTerm != "" {
                return item.title.contains(searchTerm)
            }
            else {
                return true
            }
        })
    }
    
    var body: some View {
        List {
            ForEach(filteredItems) { item in
                NavigationLink {
                    ScrollView {
                        VStack {
                            Markdown {
                                Heading {
                                    item.title
                                }
                                Heading(.level6) {
                                    if let author = item.author {
                                         "\t by " + author
                                    }
                                }
                                Paragraph {
                                    if let date = item.date {
                                         DateFormatter().string(from: date)
                                    }
                                    if let timeRequired = item.timeRequired {
                                        "\nTime Required: " + timeRequired
                                    }
                                    if let servings = item.servings {
                                        "\tServings: " + servings
                                    }
                                    if let expertise = item.expertise {
                                        "\nExpertise: " + expertise
                                    }
                                    if let calories = item.calories {
                                        "\tCalories: " + calories
                                    }
                                }
                                Heading(.level4) {
                                    "Ingredients"
                                }
                                Paragraph {
                                    item.ingredients.joined(separator: "\n")
                                }
                                Heading(.level4) {
                                    "Instructions"
                                }
                                Paragraph {
                                    item.instructions.joined(separator: "\n")
                                }
                            }
                            .padding()
                        }
                        
                    }
                } label: {
                    Text(item.title)
                    Spacer()

                    if item.favorite {
                        Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    }
                }
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
                    Label("Initialize", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem {
                Button(action: toggleShowAddModal) {
                    Label("Add Item", systemImage: "plus")
                }
                .sheet(isPresented: $showAddModal) {
                    AddModal()
                }
            }
        }
    }
        
    private func toggleShowAddModal() {
        showAddModal.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            if let recipes = loadJson(filename: "SampleData") {
                for recipe in recipes {
                    modelContext.insert(Item(title: recipe.title, ingredients: [recipe.ingredients], instructions: [recipe.instructions], author: "", date: nil, timeRequired: "", servings: "", expertise: "", calories: "", recipeCategories: [], favorite: false))
                }
            }
        }
    }
}
