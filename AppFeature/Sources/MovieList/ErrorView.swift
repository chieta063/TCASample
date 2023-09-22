import SwiftUI

enum DisplayError: Error, LocalizedError {
  case filmNotFound
  
  var errorDescription: String? {
    switch self {
    case .filmNotFound:
      return "Film not found."
    }
  }
}

struct ErrorView: View {
  let error: DisplayError
  
  var body: some View {
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

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(error: .filmNotFound)
  }
}
