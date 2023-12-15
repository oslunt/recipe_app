//
//  IterableString.swift
//  Recipes
//
//  Created by Spencer Lunt on 12/14/23.
//

import Foundation

struct IteratableString: Identifiable, Equatable, Hashable, Codable {
    var id = UUID()
    var content: String
    
    static func == (lhs: IteratableString, rhs: IteratableString) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content
    }
}
