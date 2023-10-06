import SwiftUI

struct RecipeView: View {
  var recipe: Recipe
  
  var body: some View {
    NavigationLink(value: recipe) {
      VStack(content: {
        Text(recipe.title)
      })
    }
  }
}

#Preview {
  RecipeView(recipe: Recipe.preview)
}
