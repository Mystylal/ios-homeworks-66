//
//  RealmModels.swift
//  Navigation
//
//  Created by Mysty Mystylal on 29.09.2026.
//

import Foundation
import RealmSwift

class RealmCategory: Object {
    @Persisted(primaryKey: true) var name: String = ""
}

class RealmQuote: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var value: String = ""
    @Persisted var category: String?
    @Persisted var savedAt: Date = Date()
}
