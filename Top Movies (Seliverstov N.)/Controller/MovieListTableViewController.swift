import UIKit

final class MovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var moviesArray = [Movie]()
    private let movieDataDownloader = MovieDataDownloader()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        downloadMovieData()
    }
    
    // MARK: - Methods
    
    private func configureNavigationController() {
        title = "Top Movie"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func downloadMovieData() {
        do{ try movieDataDownloader.downloadMovieData { [weak self] movies in
            self?.moviesArray = movies
            self?.tableView.reloadData()
            }
        } catch Mistakes.popularMoviesUrlIsEmpty {
            print("URL is missing")
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Protocol conformances

extension MovieListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        let movie = moviesArray[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "Vote average: \(movie.vote_average)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailScreen") as? DetailedInformationViewController {
            let movie = moviesArray[indexPath.row]
            detailViewController.movie = movie
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
