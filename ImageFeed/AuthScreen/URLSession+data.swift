import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
}

extension URLSession {
    func data(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        dataTask(with: request) { data, response, error in
            let result: Result<Data, Error>
            if let data, let status = (response as? HTTPURLResponse)?.statusCode {
                result = (200..<300).contains(status)
                    ? .success(data)
                    : .failure(NetworkError.httpStatusCode(status))
            } else if let error {
                result = .failure(NetworkError.urlRequestError(error))
            } else {
                result = .failure(NetworkError.urlSessionError)
            }
            DispatchQueue.main.async { completion(result) }
        }
    }
    
    func object<T: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionTask {
        data(for: request) { result in
            completion(result.flatMap { data in
                Result { try JSONDecoder().decode(T.self, from: data) }
                    .mapError(NetworkError.decodingError)
            })
        }
    }
}
