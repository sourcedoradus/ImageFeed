//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 08.09.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    func configure(image: UIImage, dateText: String, isLiked: Bool) {
        cellImage.image = image
        dateLabel.text = dateText
        
        let likeImage = isLiked ? UIImage(named: "LikeButtonON") : UIImage(named: "LikeButtonOFF")
        likeButton.setImage(likeImage, for: .normal)
    }
}
