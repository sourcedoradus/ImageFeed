//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 19.09.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
