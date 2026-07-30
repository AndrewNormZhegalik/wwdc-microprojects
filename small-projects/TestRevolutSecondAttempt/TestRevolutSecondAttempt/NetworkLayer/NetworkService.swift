//
//  Untitled.swift
//  TestRevolutSecondAttempt
//
//  Created by Andrey on 29.07.2026.
//
import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await session.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode)
        else {
            throw NetworkError.failedResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.failedDecoding
        }
    }
}

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case badUrl
    case failedResponse
    case failedDecoding
}
