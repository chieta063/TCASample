import SwiftUI

struct AddRecipeView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      VStack(content: {
        Text("Placeholder")
      })
      .navigationTitle("レシピ作成")
      .toolbar(content: {
        Button("Cancel") {
          dismiss()
        }
      })
    }
  }
}

#Preview {
  AddRecipeView()
}
