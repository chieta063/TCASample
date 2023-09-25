import SwiftUI

public enum DisplayError: Error, LocalizedError {
  case filmNotFound

  public var errorDescription: String? {
    switch self {
    case .filmNotFound:
      return "Film not found."
    }
  }
}

public struct ErrorView: View {
  let error: DisplayError

  public var body: some View {
    VStack {
      Image(
        systemName: "exclamationmark.triangle.fill"
      ).padding(
        .init(
          top: 0,
          leading: 0,
          bottom: 8,
          trailing: 0
        )
      )
      Text(error.localizedDescription)
        .multilineTextAlignment(.center)
    }
  }
}

public struct ErrorView_Previews: PreviewProvider {
  public static var previews: some View {
    ErrorView(error: .filmNotFound)
  }
}
