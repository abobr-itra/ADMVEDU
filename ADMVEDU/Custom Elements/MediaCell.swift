//
//  MediaCell.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import UIKit

class MediaCell: UITableViewCell {

    static let identifier = "MediaCell"
    private var media = ResultData()
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func set(media: ResultData) {
        self.media = media
        songTitle?.text = media.trackName
        artistTitle?.text = media.artistName
        if let url = media.artworkUrl60 {
            songImage?.loadImageUsingCache(withUrl: url)
        }
    }
}
