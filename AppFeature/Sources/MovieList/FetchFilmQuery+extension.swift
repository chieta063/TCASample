import Foundation
import MovieListSchema
import ComposableArchitecture

typealias FilmDetail = FilmQuery.Data.Film
typealias Character = FilmQuery.Data.Film.CharacterConnection.Character
typealias Homeworld = FilmQuery.Data.Film.CharacterConnection.Character.Homeworld

extension FilmQuery.Data.Film {
  var characterList: IdentifiedArrayOf<Character> {
    let characters = self.characterConnection?.characters?.compactMap({ $0 }) ?? []
    return IdentifiedArray(uniqueElements: characters)
  }
}

extension FilmQuery.Data.Film.CharacterConnection.Character: Identifiable {
  
}

extension FilmQuery.Data.Film.CharacterConnection.Character.Homeworld: Identifiable {
  
}
