//
//  File.swift
//  
//
//  Created by 阿部紘明 on 2023/12/01.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct SecondFeature {
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case hoge
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
}
