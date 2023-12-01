//
//  File.swift
//  
//
//  Created by 阿部紘明 on 2023/12/01.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct ParentFeature {
  public struct State: Equatable {
    public var firstFeature: FirstFeature.State
    public var secondFeature: SecondFeature.State
    
    public init(firstFeature: FirstFeature.State, secondFeature: SecondFeature.State) {
      self.firstFeature = firstFeature
      self.secondFeature = secondFeature
    }
  }
  
  public enum Action: Equatable {
    case firstFeature(FirstFeature.Action)
    case secondFeature(SecondFeature.Action)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.firstFeature, action: \.firstFeature) {
      FirstFeature()
    }
    Scope(state: \.secondFeature, action: \.secondFeature) {
      SecondFeature()
    }
    Reduce { state, action in
      switch action {
      case let .firstFeature(action):
        print(action)
        return .none
      case let .secondFeature(action):
        print(action)
        return .none
      }
    }
  }
}
