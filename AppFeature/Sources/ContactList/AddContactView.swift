import ComposableArchitecture
import SwiftUI

public struct AddContactView: View {
  let store: StoreOf<AddContactFeature>
  
  public init(store: StoreOf<AddContactFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        TextField("Name", text: viewStore.binding(get: \.contact.name, send: {
          .setName($0)
        }))
        Button("Save") {
          viewStore.send(.saveButtonTapped)
        }
      }
      .toolbar {
        ToolbarItem {
          Button("Cancel") {
            viewStore.send(.cancelButtonTapped)
          }
        }
      }
    }
  }
}

public struct AddContactView_Previews: PreviewProvider {
  public static var previews: some View {
    AddContactView(
      store: Store(
        initialState: AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        ),
        reducer: {
          AddContactFeature()
        }
      )
    )
  }
}
