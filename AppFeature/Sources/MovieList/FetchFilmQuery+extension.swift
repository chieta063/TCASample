import ComposableArchitecture
import Foundation
import MovieListSchema

public typealias FilmDetail = FilmQuery.Data.Film
public typealias Character = FilmQuery.Data.Film.CharacterConnection.Character
public typealias Homeworld = FilmQuery.Data.Film.CharacterConnection.Character.Homeworld

public extension FilmQuery.Data.Film {
  var characterList: IdentifiedArrayOf<Character> {
    let characters = characterConnection?.characters?.compactMap { $0 } ?? []
    return IdentifiedArray(uniqueElements: characters)
  }
}

extension FilmQuery.Data.Film.CharacterConnection.Character: Identifiable {}

extension FilmQuery.Data.Film.CharacterConnection.Character.Homeworld: Identifiable {}
