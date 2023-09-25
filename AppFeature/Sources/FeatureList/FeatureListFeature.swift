//
//  FeatureListFeature.swift
//  StarwarsDictionary
//
//  Created by 阿部 紘明 on 2023/07/26.
//

import ComposableArchitecture
import Foundation

public struct Feature: Equatable, Identifiable {
  public let id: UUID
  var name: String
}

public struct FeatureListFeature: Reducer {
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
