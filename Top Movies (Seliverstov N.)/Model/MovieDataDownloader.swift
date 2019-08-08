import UIKit

final class MovieDataDownloader {
    
    func downloadMovieData(completionHandler: @escaping ([Movie]) -> Void) throws {
        guard let url = URL(string: .popularMoviesUrl) else {
            throw Mistakes.popularMoviesUrlIsEmpty
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let movies = MoviesDecoder().decodeMovies(from: data)
            DispatchQueue.main.async {
                completionHandler(movies.results)
            }
        }
        task.resume()
    }
}

private extension String {
    static let popularMoviesUrl = "https://api.themoviedb.org/3/discover/movie?api_key=6bbbe01661ad34bc4dbf6a5d5b984d8d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2019&vote_average.gte=8"
}
