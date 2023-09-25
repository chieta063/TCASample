import Foundation
import MovieListSchema
import ComposableArchitecture

public typealias FilmDetail = FilmQuery.Data.Film
public typealias Character = FilmQuery.Data.Film.CharacterConnection.Character
public typealias Homeworld = FilmQuery.Data.Film.CharacterConnection.Character.Homeworld

extension FilmQuery.Data.Film {
  public var characterList: IdentifiedArrayOf<Character> {
    let characters = self.characterConnection?.characters?.compactMap({ $0 }) ?? []
    return IdentifiedArray(uniqueElements: characters)
  }
}

extension FilmQuery.Data.Film.CharacterConnection.Character: Identifiable {
  
}

extension FilmQuery.Data.Film.CharacterConnection.Character.Homeworld: Identifiable {
  
}
