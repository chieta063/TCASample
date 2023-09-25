import ComposableArchitecture
import Foundation

public struct Contact: Equatable, Identifiable {
  public let id: UUID
  var name: String
}

public struct ContactDetailFeature: Reducer {
  public struct State: Equatable {
    @PresentationState var destination: Destination.State?
    var contact: Contact

    public init(destination: Destination.State? = nil, contact: Contact) {
      self.destination = destination
      self.contact = contact
    }
  }

  public enum Action: Equatable {
    case deleteButtonTapped
    case delegate(Delegate)
    case destination(PresentationAction<Destination.Action>)
    public enum Delegate: Equatable {
      case deleteContact(id: Contact.ID)
    }

    public enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }

  @Dependency(\.dismiss) var dismiss

  public init() {}

  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
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

public extension ContactDetailFeature {
  struct Destination: Reducer {
    public enum State: Equatable {
      case alert(AlertState<ContactDetailFeature.Action.Alert>)
    }

    public enum Action: Equatable {
      case alert(ContactDetailFeature.Action.Alert)
    }

    public var body: some ReducerOf<Self> {
      EmptyReducer()
    }
  }
}

public extension AlertState where Action == ContactDetailFeature.Action.Alert {
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
