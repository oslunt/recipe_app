//
//  SearchView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/1/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showAddModal = false
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ScrollView {
                            VStack {
                                Markdown {
                                    item.title
                                }
                                .padding()
                                Markdown {
                                    item.ingredients.joined(separator: "\n")
                                }
                                .padding()
                                Markdown {
                                    item.instructions.joined(separator: "\n")
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
                    modelContext.insert(Item(title: recipe.title, ingredients: [recipe.ingredients], instructions: [recipe.instructions], author: "", date: nil, timeRequired: "", servings: "", expertise: "", calories: "", recipeCategories: nil, favorite: false))
                }
            }
        }
    }
}
