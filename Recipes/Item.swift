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
    var ingredients: [String]
    var instructions: [String]
    var author: String?
    var date: Date?
    var timeRequired: String?
    var servings: String?
    var expertise: String?
    var calories: String?
    var recipeCategories: [String]
    var favorite: Bool
    var id = UUID()
    
    init(title: String, ingredients: [String], instructions: [String], author: String? = nil, date: Date? = nil, timeRequired: String? = nil, servings: String? = nil, expertise: String? = nil, calories: String? = nil, recipeCategories: [String], favorite: Bool) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.author = author
        self.date = date
        self.timeRequired = timeRequired
        self.servings = servings
        self.expertise = expertise
        self.calories = calories
        self.recipeCategories = recipeCategories
        self.favorite = favorite
    }
}
