import UIKit

class MediaCell: UITableViewCell {
	private var media = ResultData()
	@IBOutlet private var songTitleLabel: UILabel!
	@IBOutlet private var artistTitleLabel: UILabel!
	@IBOutlet private var songImageView: UIImageView!

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

extension MediaCell: NibLoadableView {}
