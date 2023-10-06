import SwiftData
import SwiftUI

struct RecipeListView: View {
  @Query(sort: \Recipe.createDate, order: .forward)
  var recipeList: [Recipe]

  @State var selection: Recipe?
  @State var addModalOpen: Bool = false

  var body: some View {
    NavigationSplitView {
      List(selection: $selection) {
        ForEach(recipeList) { recipe in
          RecipeView(recipe: recipe)
        }
      }
      .navigationTitle("レシピ表")
      .toolbar {
        ToolbarItem {
          Button(action: {
            self.addModalOpen.toggle()
          }, label: {
            Text("作成")
          })
        }
      }
    } detail: {
      if let selection = selection {
        RecipeView(recipe: selection)
      }
    }
    .fullScreenCover(isPresented: $addModalOpen, content: {
      AddRecipeView()
    })
  }
}

#Preview {
  RecipeListView()
    .modelContainer(PreviewSampleData.container)
}
