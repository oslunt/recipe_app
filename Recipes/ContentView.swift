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
    private var categories: Set<String> {
        Set(items.flatMap { $0.recipeCategories.map(\.content) })
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Top Level Actions")) {
                    NavigationLink {
                        FilteredListView(category: "", filterIsFavorite: false, items: items)
                    } label: {
                        Text("Browse All")
                    }
                    
                    NavigationLink {
                        FilteredListView(category: "", filterIsFavorite: true, items: items.filter { $0.favorite })
                    } label: {
                        Text("Favorites")
                    }
                }
                Section(header: Text("Categories")) {
                    ForEach(Array(categories), id: \.self) { category in
                        NavigationLink {
                            FilteredListView(category: category, filterIsFavorite: false, items: items.filter { $0.contains(wherestring: category)})
                        } label: {
                            Text(category)
                        }
                    }
                }
            }
        } content: {
            FilteredListView(category: "",  filterIsFavorite: false, items: items)
        } detail: {
            Text("Select an item")
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
