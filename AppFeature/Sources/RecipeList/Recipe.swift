import Foundation
import SwiftData

@Model
struct Recipe: Identifiable {
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
