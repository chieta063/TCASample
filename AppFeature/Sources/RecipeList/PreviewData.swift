import Foundation
import SwiftData
import SwiftUI

// actorは同一インスタンス内のデータ競合を防いでくれる。
// noisolate funcにするとデータ競合の防止を無効化できる。
// （actorのメソッドやフィールドにアクセスするときにawaitが必要だが必要なくなる）
actor PreviewSampleData {
  
  @MainActor
  static var container: ModelContainer = {
    return try! inMemoryContainer()
  }()
  
  static var inMemoryContainer: () throws -> ModelContainer = {
    let schema = Schema([Recipe.self])
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: configuration)
    let sampleData: [any PersistentModel] = [
      Recipe.preview
    ]
    Task { @MainActor in
      sampleData.forEach {
        container.mainContext.insert($0)
      }
    }
    return container
  }
}
