//
//  BasicInformationSectionView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

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
