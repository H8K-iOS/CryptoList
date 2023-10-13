import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknownError(String = "An unknown error")
    case decodingError(String = "Error parsign server response")
}

class CoinService {
    static func fetchCoins(with endpoint: Endpoint,
                           completion: @escaping(Result<[Coin], CoinServiceError>) -> Void) {
        
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            
            if let error = error {
                completion(.failure(.unknownError(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                    
                } catch let err {
                    completion(.failure(.unknownError()))
                    print(err.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data).data
                    completion(.success(coinData))
                    
                } catch {
                    completion(.failure(.decodingError()))
                    print(error.localizedDescription)
                }
            } else {
                completion(.failure(.unknownError()))
            }
        }.resume()
    }
}
