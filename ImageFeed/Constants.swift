import Foundation

enum Constants {
    static let accessKey = "8OMU9ECyFHx2_Qd3IJW0ktB0HClKluwTonyQhvt2pS4"
    static let secretKey = "LFzxiUqTOYsWW1RI7Sy4_hGE6sLGZQe1BMzAGuBfX6Y"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public read_user write_likes"
    static let authorizeURL = "https://unsplash.com/oauth/authorize"
    static let tokenURL = "https://unsplash.com/oauth/token"
    
    static func url(_ string: String, _ query: [String: String]) -> URL? {
        var components = URLComponents(string: string)
        components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}
