import ComposableArchitecture
import SwiftUI

public struct ContactDetailView: View {
  let store: StoreOf<ContactDetailFeature>

  public init(store: StoreOf<ContactDetailFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        Button("Delete") {
          viewStore.send(.deleteButtonTapped)
        }
      }
      .navigationBarTitle(Text(viewStore.contact.name))
      .toolbar {
        ToolbarItem {
          Button("Cancel") {}
        }
      }
    }
    .alert(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContactDetailFeature.Destination.State.alert,
      action: ContactDetailFeature.Destination.Action.alert
    )
  }
}

public struct ContactDetailView_Previews: PreviewProvider {
  public static var previews: some View {
    ContactDetailView(
      store: Store(
        initialState: ContactDetailFeature.State(
          contact: Contact(id: UUID(), name: "Blob")
        ),
        reducer: {
          ContactDetailFeature()
        }
      )
    )
  }
}
