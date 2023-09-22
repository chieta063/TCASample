import Foundation
import Foundation
import Apollo

class Network {
  static let shared = Network()
  
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!)
}
