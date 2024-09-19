//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 14.09.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private var AvatarImageView: UIImageView!
    @IBOutlet private var logoutButton: UIButton!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBAction private func didTapLogoutButton(_ sender: Any) {
    }
}
