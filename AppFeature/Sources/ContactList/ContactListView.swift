import ComposableArchitecture
import SwiftUI

public struct ContactListView: View {
  let store: StoreOf<ContactsFeature>
  
  public init(store: StoreOf<ContactsFeature>) {
    self.store = store
  }
  
  public var body: some View {
    List {
      ForEachStore(store.scope(
        state: \.contacts,
        action: ContactsFeature.Action.contacts(id:action:)
      )) { store in
        WithViewStore(store, observe: { $0 }) { contactViewStore in
          HStack {
            Text(contactViewStore.name)
            Spacer()
          }
          .onTapGesture {
            self.store.send(
              .cellTapped(
                Contact(id: contactViewStore.id, name: contactViewStore.name)
              )
            )
          }
        }
      }
    }
    .navigationTitle("Contacts")
    .toolbar {
      ToolbarItem {
        Button {
          store.send(.addButtonTapped)
        } label: {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContactsFeature.Destination.State.addContact,
      action: ContactsFeature.Destination.Action.addContact,
      content: { store in
        NavigationStack {
          AddContactView(store: store)
        }
      }
    )
    .sheet(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContactsFeature.Destination.State.contact,
      action: ContactsFeature.Destination.Action.contact,
      content: { store in
        NavigationStack {
          ContactDetailView(store: store)
        }
      }
    )
  }
}

public struct ContactListView_Preview: PreviewProvider {
  public static var previews: some View {
    ContactListView(store: Store(initialState: ContactsFeature.State(), reducer: {
      ContactsFeature()
    }, withDependencies: { dependency in
      dependency.uuid = UUIDGenerator({
        UUID()
      })
    }))
  }
}
