//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 29.09.2024.
//

import UIKit

final class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWebView" {
            // Подготовка к переходу на WebViewViewController, если необходимо
            if let webViewVC = segue.destination as? WebViewViewController {
                // Здесь можно передать данные в webViewVC, если нужно
            }
        }
    }

    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button") // 1
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button") // 2
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // 3
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black") // 4
    }
}
