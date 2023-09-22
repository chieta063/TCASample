// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MovieListSchema.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MovieListSchema.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MovieListSchema.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MovieListSchema.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Root": return MovieListSchema.Objects.Root
    case "Film": return MovieListSchema.Objects.Film
    case "Species": return MovieListSchema.Objects.Species
    case "Planet": return MovieListSchema.Objects.Planet
    case "Person": return MovieListSchema.Objects.Person
    case "Starship": return MovieListSchema.Objects.Starship
    case "Vehicle": return MovieListSchema.Objects.Vehicle
    case "FilmCharactersConnection": return MovieListSchema.Objects.FilmCharactersConnection
    case "FilmsConnection": return MovieListSchema.Objects.FilmsConnection
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
