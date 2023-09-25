//
//  FeatureListView.swift
//  StarwarsDictionary
//
//  Created by 阿部 紘明 on 2023/07/26.
//

import ComposableArchitecture
import ContactList
import Counter
import MovieList
import NavigationList
import SwiftUI

public struct FeatureListView: View {
  let store: StoreOf<FeatureListFeature>

  public init(store: StoreOf<FeatureListFeature>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      Form(content: {
        NavigationLink(
          "Counter",
          destination: CounterView(
            store: Store(initialState: CounterFeature.State(), reducer: {
              CounterFeature()
            })
          )
        )
        NavigationLink(
          "ContactList",
          destination: ContactListView(
            store: Store(initialState: ContactsFeature.State(), reducer: {
              ContactsFeature()
            })
          )
        )
        NavigationLink(
          "StarwarsDictionary",
          destination: MovieListView(store: Store(initialState: MovieListFeature.State(), reducer: {
            MovieListFeature()
          }))
        )
        NavigationLink(
          "Navigations",
          destination: NavigationListView(store: Store(initialState: NavigationListFeature.State(), reducer: {
            NavigationListFeature()
          }))
        )
      })
    }
  }
}

public struct FeatureListView_Previews: PreviewProvider {
  public static var previews: some View {
    FeatureListView(store: Store(initialState: FeatureListFeature.State(), reducer: {
      FeatureListFeature()
    }))
  }
}
