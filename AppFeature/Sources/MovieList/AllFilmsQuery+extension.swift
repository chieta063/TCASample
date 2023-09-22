import Foundation
import Apollo
import MovieListSchema

typealias FilmData = AllFilmsQuery.Data.AllFilms.Film

extension AllFilmsQuery.Data.AllFilms.Film: Identifiable {
  
}
