import UIKit

final class DetailedInformationViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var movieOverviewTextView: UITextView!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var scheduleNotificationButton: UIButton!
    @IBOutlet private weak var selectDateButton: UIButton!
    @IBOutlet private weak var datePickerWithButtonStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.minimumDate = Date()
        }
    }
    
    var movie: Movie?
    
    //MARK: - Action
    
    @IBAction func selectDateButton(_ sender: UIButton) {
        UserNotificationManager.shared.scheduleLocalNotification(withTitle: movieTitleLabel.text ?? "", andDate: datePicker.date)
        datePickerWithButtonStackView.isHidden = true
        backgroundView.isHidden = true
    }
    
    @IBAction func scheduleNotificationButton(_ sender: UIButton) {
        datePickerWithButtonStackView.isHidden = false
        backgroundView.isHidden = false
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        UserNotificationManager.shared.registerLocalNotifications()
        displayMovieInfo()
    }
    
    // MARK: - Method
    
    private func displayMovieInfo() {
        guard let movie = movie else {
            return
        }
        
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.vote_average)"
        movieReleaseDateLabel.text = "Date: \(movie.release_date)"
        movieOverviewTextView.text = movie.overview
        
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + movie.poster_path) {
            self.activityIndicator.startAnimating()
            DispatchQueue.global(qos: .utility).async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.moviePosterImageView.image = UIImage(data: data)
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.isHidden = true
                    }
                }
            }
        }
    }
}
