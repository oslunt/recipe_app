//
//  Item.swift
//  Recipes
//
//  Created by IS 543 on 11/27/23.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    var title: String
    var ingredients: [IteratableString]
    var instructions: [IteratableString]
    var author: String?
    var timeRequired: String?
    var servings: String?
    var expertise: String?
    var calories: String?
    var recipeCategories: [IteratableString]
    var favorite: Bool
    var id = UUID()
    
    init(title: String, ingredients: [IteratableString], instructions: [IteratableString], author: String? = nil, timeRequired: String? = nil, servings: String? = nil, expertise: String? = nil, calories: String? = nil, recipeCategories: [IteratableString], favorite: Bool) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.author = author
        self.timeRequired = timeRequired
        self.servings = servings
        self.expertise = expertise
        self.calories = calories
        self.recipeCategories = recipeCategories
        self.favorite = favorite
    }
    
    func contains(wherestring: String) -> Bool {
        for recipeCategory in recipeCategories {
            if recipeCategory.content == wherestring {
                return true
            }
        }
        return false
    }
}
