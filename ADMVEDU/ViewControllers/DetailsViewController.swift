//
//  DetailsViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var genreTitle: UILabel!
    @IBOutlet weak var collectionTitle: UILabel!
    var media = ResultData()

    override func viewDidLoad() {
        super.viewDidLoad()
        //setDelegates()
        set(media)
    }
    
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
}
*/
