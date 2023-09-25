import Foundation
import Apollo
import MovieListSchema

public typealias FilmData = AllFilmsQuery.Data.AllFilms.Film

extension AllFilmsQuery.Data.AllFilms.Film: Identifiable {
  
}
