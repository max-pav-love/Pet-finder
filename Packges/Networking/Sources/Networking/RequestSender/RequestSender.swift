//
//  RequestSender.swift
//  
//
//  Created by Maksim Khlestkin on 12.07.2023.
//

import Foundation

public protocol RequestSenderProtocol {
    func send<Request: RequestProtocol>(request: Request) async -> Result<Request.Response, Error>
    func sendTokenRequest() async -> Error?
}

public final class RequestSender: RequestSenderProtocol {
    
    // MARK: - Singletone -
    
    public static let live: RequestSenderProtocol = RequestSender()
    
    private init() { }
    
    // MARK: - Properties -
    
    private lazy var urlSession = URLSession(configuration: sessionConfiguration)
    
    private var baseHeaders: [String: String] {
        var headers = ["Content-Type": "application/json"]
        if let token = getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    private var sessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        return configuration
    }()
    
    // MARK: - RequestSenderProtocol -
    
    public func send<R: RequestProtocol>(request: R) async -> Result<R.Response, Error> {
        let urlRequest = makeUrlRequest(from: request)
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            print(" = RequestSender = ")
            print("Request: \(urlRequest)")
            
            if let urlResponse = response as? HTTPURLResponse {
                print(" - Response - ")
                print("StatusCode: \(urlResponse.statusCode)")
                
                if (200..<300).contains(urlResponse.statusCode) {
                    let responseObject = try JSONDecoder().decode(
                        request.response,
                        from: data)
                    if let json = String(data: data, encoding: .utf8) {
                        print("Response: \(json)")
                    }
                    return .success(responseObject)
                }
            }
            
            let error = try JSONDecoder().decode(
                ErrorResponse.self,
                from: data)
            print("!ResponseError!: \(error)")
            print(" /= RequestSender =/ ")
            return .failure(error)
        } catch {
            print("!Error!: \(error)")
            print(" /= RequestSender =/ ")
            return .failure(error)
        }
    }
    
    public func sendTokenRequest() async -> Error? {
        let request = TokenRequest()
        let result = await send(request: request)
        switch result {
        case let .success(token):
            UserDefaults.standard.set(token.access_token, forKey: "jwt_token")
            return nil
        case let .failure(error):
            return error
        }
    }
    
    // MARK: - Private -
    
    private func makeUrlRequest(from request: any RequestProtocol) -> URLRequest {
        let url = getUrl(from: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = getHttpMetod(from: request)
        if getHttpMetod(from: request) != "GET" {
            urlRequest.httpBody = getHttpBody(from: request)
        }
        
        baseHeaders.forEach { (field, value) in
            urlRequest.setValue(value, forHTTPHeaderField: field)
        }
        
        return urlRequest
    }
    
    private func getUrl(from request: any RequestProtocol) -> URL {
        request.endpoint.apiUrl
    }
    
    private func getHttpMetod(from request: any RequestProtocol) -> String {
        request.method.rawValue
    }
    
    private func getHttpBody(from request: any RequestProtocol) -> Data? {
        guard let parameters = request.parameters() else {
            return nil
        }
        do {
            let body = try JSONSerialization.data(withJSONObject: parameters)
            return body
        } catch {
            print("HttpBody Encoding Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    private func getToken() -> String? {
        UserDefaults.standard.string(forKey: "jwt_token")
    }
        
}
