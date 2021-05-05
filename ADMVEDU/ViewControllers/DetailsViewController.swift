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
    
    var media = ResultData()

    override func viewDidLoad() {
        super.viewDidLoad()
        set(media)
    }


    func set(_ media: ResultData) {
        
        self.media = media
        mediaTitle?.text = media.trackName
        artistTitle?.text = media.artistName
        if let url = media.artworkUrl100 {
            imgView?.loadImageUsingCache(withUrl: url)
        }
    }

}


