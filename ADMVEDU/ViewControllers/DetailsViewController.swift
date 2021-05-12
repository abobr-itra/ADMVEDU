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
        //setDelegates()
        set(media)
    }
    
    func set(_ media: ResultData) {
<<<<<<< HEAD
        //self.media = media
        mediaTitle?.text = media.trackName
        artistTitle?.text = media.artistName
=======

        mediaTitleLabel?.text = media.trackName
        artistTitleLabel?.text = media.artistName
>>>>>>> 115
        if let genre = media.primaryGenreName {
            genreTitleLabel?.text = "Genre: \(genre)"
        }

        collectionTitleLable?.text = media.collectionName
        if let url = media.artworkUrl100 {
            imageView?.loadImageUsingCache(withUrl: url)
        }
    }
<<<<<<< HEAD
/*
    func setDelegates() {
        let rootVC = ViewController()
        rootVC.delegate = self
    }*/
}
/*
extension DetailsViewController: DetailsDelegate {
    func set(_ media: ResultData) {
        //self.media = media
        mediaTitle?.text = media.trackName
        artistTitle?.text = media.artistName
        if let genre = media.primaryGenreName {
            genreTitle?.text = "Genre: \(genre)"
        }

        collectionTitle?.text = media.collectionName
        if let url = media.artworkUrl100 {
            imgView?.loadImageUsingCache(withUrl: url)
        }
    }
=======
>>>>>>> 115
}
*/
