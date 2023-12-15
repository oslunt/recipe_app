//
//  ContentView.swift
//  Recipes
//
//  Created by IS 543 on 11/27/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

// Pair programming buddy conversations https://chat.openai.com/share/dc0d7313-6c68-4f89-b079-c457edf51864
//https://stackoverflow.com/questions/75247994/navigationsplitview-not-updating

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
                            .id(1)
                    } label: {
                        Text("Browse All")
                    }
                    
                    NavigationLink {
                        FilteredListView(category: "", filterIsFavorite: true, items: items.filter { $0.favorite })
                            .id(2)
                    } label: {
                        Text("Favorites")
                    }
                }
                Section(header: Text("Categories")) {
                    ForEach(Array(categories), id: \.self) { category in
                        NavigationLink {
                            FilteredListView(category: category, filterIsFavorite: false, items: items.filter { $0.contains(wherestring: category)})
                                .id(3)
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
