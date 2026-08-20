import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    func configure(image: UIImage, dateText: String, isLiked: Bool) {
        cellImage.image = image
        dateLabel.text = dateText
        likeButton.setImage(UIImage(named: isLiked ? "LikeButtonON" : "LikeButtonOFF"), for: .normal)
    }
}
