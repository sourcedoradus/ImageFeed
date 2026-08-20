import Foundation

final class OAuth2Service {
    static let shared = OAuth2Service()
    
    private let storage = OAuth2TokenStorage()
    private var task: URLSessionTask?
    
    var authToken: String? {
        get { storage.token }
        set { storage.token = newValue }
    }
    
    private init() {}
    
    private struct TokenResponse: Decodable {
        let accessToken: String
        enum CodingKeys: String, CodingKey { case accessToken = "access_token" }
    }
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        guard task == nil else { return }
        guard let request = Self.tokenRequest(code: code) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        task = URLSession.shared.object(for: request) { [weak self] (result: Result<TokenResponse, Error>) in
            self?.task = nil
            if case .success(let body) = result { self?.authToken = body.accessToken }
            completion(result.map(\.accessToken))
        }
        task?.resume()
    }
    
    private static func tokenRequest(code: String) -> URLRequest? {
        guard let url = Constants.url(Constants.tokenURL, [
            "client_id": Constants.accessKey,
            "client_secret": Constants.secretKey,
            "redirect_uri": Constants.redirectURI,
            "code": code,
            "grant_type": "authorization_code"
        ]) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}
