//
//  ContentView.swift
//  Recipes
//
//  Created by IS 543 on 11/27/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showAddModal = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                // A section of top-level abilities like browse all, search, favorites
                Section(header: Text("Top Level Actions")) {
                    NavigationLink {
                        BrowseAllListView()
                    } label: {
                        Text("Browse All")
                    }

                    NavigationLink {
                        SearchView()
                    } label: {
                        Text("Search")
                    }
                    
                    NavigationLink {
                        FavoritesView(favorite: false)
                    } label: {
                        Text("Favorites")
                    }
                }

                // Categories
                Section(header: Text("Categories")) {
                    ForEach(items) { item in
                        if let recipeCategories = item.recipeCategories {
                            ForEach(recipeCategories, id: \.self) { category in
                                NavigationLink {
                                    CategoryView(category: category)
                                } label: {
                                    Text(category)
                                }
                            }
                        }
                    }
                }
            }
        } content: {
            BrowseAllListView()
        } detail: {
            Text("Select an item")
        }
    }
//    
//    private var browseAllList: some View {
//        List {
//            ForEach(items) { item in
//                NavigationLink {
//                    ScrollView {
//                        VStack {
//                            Markdown {
//                                item.title
//                            }
//                            .padding()
//                            Markdown {
//                                item.ingredients.joined(separator: "\n")
//                            }
//                            .padding()
//                            Markdown {
//                                item.instructions.joined(separator: "\n")
//                            }
//                            .padding()
//                        }
//                    }
//                } label: {
//                    Text(item.title)
//                }
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            ToolbarItem {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: initializeRecipes) {
//                    Label("Initialize", systemImage: "folder.badge.plus")
//                }
//            }
//            ToolbarItem {
//                Button(action: toggleShowAddModal) {
//                    Label("Add Item", systemImage: "plus")
//                }
//                .sheet(isPresented: $showAddModal) {
//                    AddModal()
//                }
//            }
//        }
//    }
//    
//    private func toggleShowAddModal() {
//        showAddModal.toggle()
//    }
//
////    private func addItem() {
////        withAnimation {
////            let newItem = Item(title: "some item", ingredients: "some stuff", instructions: "do something")
////            modelContext.insert(newItem)
////        }
////    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//    
//    private func initializeRecipes() {
//        withAnimation {
//            if let recipes = loadJson(filename: "SampleData") {
//                for recipe in recipes {
//                    modelContext.insert(Item(title: recipe.title, ingredients: [recipe.ingredients], instructions: [recipe.instructions], author: "", date: nil, timeRequired: "", servings: "", expertise: "", calories: "", recipeCategories: nil, favorite: false))
//                }
//            }
//        }
//    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
