//
//  DetailsViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import UIKit
import AVFoundation
import AVKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mediaTitleLabel: UILabel!
    @IBOutlet private weak var artistTitleLabel: UILabel!
    @IBOutlet private weak var genreTitleLabel: UILabel!
    @IBOutlet private weak var collectionTitleLable: UILabel!
    @IBOutlet private weak var playButton: UIButton!

    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()

    var media = ResultData()

    override func viewDidLoad() {
        super.viewDidLoad()
        set(media)
        configurePlayer()
    }

    @IBAction func playButtonClicked(_ sender: Any) {
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }

    private func configurePlayer() {
        guard let urlString = media.previewURL, let url = URL(string: urlString) else {
            return
        }

        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
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
