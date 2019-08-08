import Foundation

final class MoviesDecoder {
    func decodeMovies(from data: Data) -> Movies {
        let decoder = JSONDecoder()
        return (try? decoder.decode(Movies.self, from: data)) ?? Movies(results: [])
    }
}
