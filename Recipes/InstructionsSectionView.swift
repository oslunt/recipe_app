//
//  InstructionsSectionView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

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
