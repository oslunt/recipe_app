//
//  IngredientsSectionView.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

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
