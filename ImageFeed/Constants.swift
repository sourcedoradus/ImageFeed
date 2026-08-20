//
//  Constants.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 26.09.2024.
//

import Foundation

enum Constants {
    
    static let accessKey = "8OMU9ECyFHx2_Qd3IJW0ktB0HClKluwTonyQhvt2pS4"
    static let secretKey = "LFzxiUqTOYsWW1RI7Sy4_hGE6sLGZQe1BMzAGuBfX6Y"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public read_user write_likes"
    
    static let defaultBaseURL: URL = {
        guard let url = URL(string: "https://api.unsplash.com") else {
            fatalError("Invalid URL")
        }
        return url
    }()
}
