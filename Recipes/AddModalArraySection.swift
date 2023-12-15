//
//  AddModalArraySection.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct AddModalArraySection: View {
    @Binding var recipeItemArray: [IteratableString]
    var title: String
    var singularType: String
    
    var body: some View {
        Section(header: Text(title)) {
            List {
                ForEach(recipeItemArray) { instruction in
                    let index = recipeItemArray.firstIndex(of: instruction) ?? 0
                    TextField("\(singularType) \(index + 1)", text: $recipeItemArray[index].content)
                }
                .onDelete(perform: { indexSet in
                    recipeItemArray.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    recipeItemArray.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            Button {
                withAnimation {
                    recipeItemArray.append(IteratableString(content: ""))
                }
            } label: {
                Text("Add Step")
            }
        }
    }
}
