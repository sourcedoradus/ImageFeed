//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 29.09.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWebView" {
            // Подготовка к переходу на WebViewViewController, если необходимо
            if let webViewVC = segue.destination as? WebViewViewController {
                // Здесь можно передать данные в webViewVC, если нужно
            }
        }
    }
}
