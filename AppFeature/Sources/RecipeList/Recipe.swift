import Foundation
import SwiftData

@Model
class Recipe: Identifiable {
  @Attribute(.unique) var id: String
  var title: String
  var recipe: String
  var createDate: Date
  
  init(id: String, title: String, recipe: String, createDate: Date) {
    self.id = id
    self.title = title
    self.recipe = recipe
    self.createDate = createDate
  }
}

extension Recipe {
  static var preview: Recipe {
    .init(id: "1", title: "レシピ１", recipe: "レシピ１の作り方", createDate: .init())
  }
}
