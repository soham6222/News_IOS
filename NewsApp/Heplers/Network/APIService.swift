//
//  APIService.swift
//  Generic API Layer
//
//  Created by user238596 on 10/04/24
//

import Foundation

enum APIService {
    /**
     * Request data from an API endpoint.
     *
     * - Parameters:
     *   - `rout`: The API endpoint to request.
     * - Returns: The decoded data from the API endpoint.
     * - Throws: An error if the request fails.
     */
    static func request<T: Codable>(_ rout: APIProtocol) async throws -> T {
        let (data, res) = try await URLSession.shared.data(for: rout.asURLRequest())
        let statusCode = (res as? HTTPURLResponse)?.statusCode ?? 400
        switch statusCode {
        case 200 ... 299:
            return try JSONDecoder().decode(T.self, from: data)
        default:
            throw APIError.badRequest
        }
    }
}
