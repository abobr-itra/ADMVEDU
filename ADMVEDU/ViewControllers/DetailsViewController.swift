import AVFoundation
import AVKit
import UIKit

class DetailsViewController: UIViewController {
	@IBOutlet private var imageView: UIImageView!
	@IBOutlet private var mediaTitleLabel: UILabel!
    @IBOutlet private var artistTitleLabel: UILabel!
    @IBOutlet private var genreTitleLabel: UILabel!
	@IBOutlet private var collectionTitleLable: UILabel!
	@IBOutlet private var playButton: UIButton!

    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()

    var media = ResultData()

    override func viewDidLoad() {
        super.viewDidLoad()
        set(media)
        configurePlayer()
    }

    @IBAction private func playButtonClicked(_: Any) {
        present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }

    private func configurePlayer() {
        guard let urlString = media.previewUrl, let url = URL(string: urlString) else {
            return
        }

        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        playerViewController.player = player
    }

    private func set(_ media: ResultData) {
        mediaTitleLabel?.text = media.trackName
        artistTitleLabel?.text = media.artistName
        if let genre = media.primaryGenreName {
            genreTitleLabel?.text = "Genre: \(genre)"
        }

        collectionTitleLable?.text = media.collectionName
        if let url = media.artworkUrl100 {
            imageView?.loadImageUsingCache(withUrl: url)
        }
    }
}
