//
//  DetailsViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mediaTitleLabel: UILabel!
    @IBOutlet private weak var artistTitleLabel: UILabel!
    @IBOutlet private weak var genreTitleLabel: UILabel!
    @IBOutlet private weak var collectionTitleLable: UILabel!
    var media = ResultData()

    override func viewDidLoad() {
        super.viewDidLoad()
        set(media)
    }

    func set(_ media: ResultData) {
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
