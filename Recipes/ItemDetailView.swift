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
