//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 14.09.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Avatar image
        
        let avatarImage = UIImageView(image: UIImage(named: "Avatar"))
        view.addSubview(avatarImage)
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        // MARK: - Name label
        
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 23.0, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        // MARK: - Login name label
        
        let loginNameLabel = UILabel()
        loginNameLabel.text = "@ekaterina_nov"
        view.addSubview(loginNameLabel)
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        loginNameLabel.textColor = UIColor(named: "YP Gray")
        loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        loginNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        // MARK: - Description label
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Hello, World!"
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        // MARK: - Logout button
        
        let logoutButton = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(Self.didTapLogoutButton)
        )
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.tintColor = UIColor(named: "YP Red")
        logoutButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    // MARK: - Functions
    
    @objc
    private func didTapLogoutButton() {
    }
}
