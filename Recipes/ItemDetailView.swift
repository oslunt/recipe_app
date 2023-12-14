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
                VStack(alignment: .leading, spacing: 16) {
                    BasicInformationSection(item: item)
                    IngredientsSection(item: item)
                    InstructionsSection(item: item)                }
                .padding()
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
            HStack {
                Text(item.title)
                Spacer()
                
                if item.favorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
    
    private func toggleShowAddModal() {
        showAddModal.toggle()
    }
}

struct InfoRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            Spacer()
            Text(value)
        }
    }
}

struct BasicInformationSection: View {
    var item: Item
    
    var body: some View {
        Section(header: HStack {
            Text(item.title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                item.favorite.toggle()
            } label: {
                Image(systemName: item.favorite ? "star.fill" : "star")
                    .foregroundColor(item.favorite ? .yellow : .gray)
            }
        }) {
            if let author = item.author, !author.isEmpty {
                Text(author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            InfoRow(title: "Time Required", value: item.timeRequired ?? "N/A")
            InfoRow(title: "Servings", value: item.servings ?? "N/A")
            InfoRow(title: "Expertise", value: item.expertise ?? "N/A")
            InfoRow(title: "Calories", value: item.calories ?? "N/A")
        }
    }
}

struct InstructionRow: View {
    var index: Int
    var content: String
    
    var body: some View {
        HStack {
            Text("\(index).")
                .bold()
            Text(content)
        }
        .padding(.bottom, 8)
    }
}

struct InstructionsSection: View {
    var item: Item
    
    var body: some View {
        Section(header: Text("Instructions").font(.title).bold()) {
            ForEach(item.instructions.indices, id: \.self) { index in
                InstructionRow(index: index + 1, content: item.instructions[index].content)
            }
        }
    }
}

struct IngredientsSection: View {
    var item: Item
    
    var body: some View {
        Section(header: Text("Ingredients").font(.title).bold()) {
            ForEach(item.ingredients) { ingredient in
                Text(ingredient.content)
            }
            .padding(.bottom, 8)
        }
    }
}
