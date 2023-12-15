//
//  InstructionRowView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

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
