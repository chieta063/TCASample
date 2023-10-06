import SwiftUI
import SwiftData

struct RecipeListView: View {
  @Query(sort: \Recipe.createDate, order: .forward)
  var recipeList: [Recipe]
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

#Preview {
  RecipeListView()
}
