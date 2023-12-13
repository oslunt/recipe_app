//
//  ItemDetailView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/4/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ItemDetailView: View {
    var item: Item
    @State private var showAddModal = false
    
    var body: some View {
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
                            if let timeRequired = item.timeRequired {
                                if timeRequired.count > 0 {
                                    "\nTime Required: " + timeRequired
                                }
                            }
                            if let servings = item.servings {
                                if servings.count > 0 {
                                    "\tServings: " + servings
                                }
                            }
                            if let expertise = item.expertise {
                                if expertise.count > 0 {
                                    "\nExpertise: " + expertise
                                }
                            }
                            if let calories = item.calories {
                                if calories.count > 0 {
                                    "\tCalories: " + calories
                                }
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
            .toolbar {
                ToolbarItem {
                    Button(action: toggleShowAddModal) {
                        Label("Edit Item", systemImage: "pencil")
                    }
                    .sheet(isPresented: $showAddModal) {
                        AddModal(recipe: item)
                    }
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
    
    private func toggleShowAddModal() {
        showAddModal.toggle()
    }
}
