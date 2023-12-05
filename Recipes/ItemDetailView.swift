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
                Button(action: toggleShowAddModal) {
                    Label("Edit Item", systemImage: "plus")
                }
                .sheet(isPresented: $showAddModal) {
                    AddModal()
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
