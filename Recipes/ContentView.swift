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
        var setCategories = Set<String>()
        
        for item in items {
            setCategories.formUnion(item.recipeCategories)
        }
        
        return setCategories
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Top Level Actions")) {
                    NavigationLink {
                        FilteredListView(filterCategories: false, category: "", filterFavorites: false, searchTerm: "")
                    } label: {
                        Text("Browse All")
                    }
                    
                    NavigationLink {
                        FilteredListView(filterCategories: false, category: "", filterFavorites: true, searchTerm: "")
                    } label: {
                        Text("Favorites")
                    }
                }
                Section(header: Text("Categories")) {
                    ForEach(Array(categories), id: \.self) { category in
                        NavigationLink {
                            FilteredListView(filterCategories: true, category: category, filterFavorites: false, searchTerm: "")
                        } label: {
                            Text(category)
                        }
                    }
                }
            }
        } content: {
            FilteredListView(filterCategories: false, category: "", filterFavorites: false, searchTerm: "")
        } detail: {
            Text("Select an item")
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
