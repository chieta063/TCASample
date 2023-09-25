import ComposableArchitecture
import Foundation
import SwiftUI

public struct ContactsFeature: Reducer {
  public struct State: Equatable {
    @PresentationState var destination: Destination.State?
    var contacts: IdentifiedArrayOf<Contact> = []
    
    public init(destination: Destination.State? = nil, contacts: IdentifiedArrayOf<Contact> = []) {
      self.destination = destination
      self.contacts = contacts
    }
  }
  
  public enum Action: Equatable {
    case contacts(id: Contact.ID, action: ContactDetailFeature.Action)
    case addButtonTapped
    case cellTapped(Contact)
    case destination(PresentationAction<Destination.Action>)
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  
  // Test時にUUIDをMockできるようにするために依存関係を追加する
  @Dependency(\.uuid) var uuid
  
  @Environment(\.presentationMode) var presentation
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.destination = .addContact(
          AddContactFeature.State(
            contact: Contact(id: self.uuid(), name: "")
          )
        )
        return .none
      case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
        state.contacts.append(contact)
        return .none
      case let .destination(.presented(.contact(.delegate(.deleteContact(id))))):
        state.contacts.remove(id: id)
        return .none
      case let .cellTapped(contact):
        state.destination = .contact(ContactDetailFeature.State(contact: contact))
        return .none
      default:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}

extension ContactsFeature {
  public struct Destination: Reducer {
    public enum State: Equatable {
      case addContact(AddContactFeature.State)
      case contact(ContactDetailFeature.State)
    }
    
    public enum Action: Equatable {
      case addContact(AddContactFeature.Action)
      case contact(ContactDetailFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
      Scope(state: /State.addContact, action: /Action.addContact) {
        AddContactFeature()
      }
      Scope(state: /State.contact, action: /Action.contact) {
        ContactDetailFeature()
      }
    }
  }
}
