//
//  MediaCell.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import UIKit

class MediaCell: UITableViewCell {

    private var media = ResultData()

    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var artistTitleLabel: UILabel!
    @IBOutlet private weak var songImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear

    }

    func set(media: ResultData) {
        self.media = media
        songTitleLabel?.text = media.trackName
        artistTitleLabel?.text = media.artistName
        if let url = media.artworkUrl60 {
            songImageView?.loadImageUsingCache(withUrl: url)
        }
    }
}

extension MediaCell: NibLoadableView {
}
