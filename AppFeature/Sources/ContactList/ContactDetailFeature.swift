import ComposableArchitecture
import Foundation

struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}

struct ContactDetailFeature: Reducer {
  struct State: Equatable {
    @PresentationState var destination: Destination.State?
    var contact: Contact
  }
  
  enum Action: Equatable {
    case deleteButtonTapped
    case delegate(Delegate)
    case destination(PresentationAction<Destination.Action>)
    enum Delegate: Equatable {
      case deleteContact(id: Contact.ID)
    }
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .deleteButtonTapped:
      state.destination = .alert(.deleteConfirmation(id: state.contact.id))
      return .none
    case let .destination(.presented(.alert(.confirmDeletion(id)))):
      return .run { send in
        await send(.delegate(.deleteContact(id: id)))
        await self.dismiss()
      }
    default:
      return .none
    }
  }
}

extension ContactDetailFeature {
  struct Destination: Reducer {
    enum State: Equatable {
      case alert(AlertState<ContactDetailFeature.Action.Alert>)
    }
    enum Action: Equatable {
      case alert(ContactDetailFeature.Action.Alert)
    }
    
    var body: some ReducerOf<Self> {
      EmptyReducer()
    }
  }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
  static func deleteConfirmation(id: UUID) -> Self {
    Self {
      TextState("Are you sure?")
    } actions: {
      ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
        TextState("Delete")
      }
    }
  }
}
