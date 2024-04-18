//
//  Enums.swift
//  Squeezee
//
//  Created by user238596 on 10/04/24
//

import Foundation

// MARK: - APIError

enum APIError: Error {
    case badRequest

    case invalidURL(urlStr: String)
}

// MARK: - CustomStringConvertible
extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badRequest:
            return "Api request is bad."
        case let .invalidURL(urlStr):
            return "\(urlStr) is invalid url."
        }
    }
}

// MARK: - APIMethod
/**
 *  An enumeration of the supported HTTP methods for making an API request.
 */
enum APIMethod: String {
    /**
     *  Indicates a GET request.
     */
    case get

    /**
     *  Indicates a POST request.
     */
    case post

    /**
     *  Indicates a PUT request.
     */
    case put

    /**
     *  Indicates a PATCH request.
     */
    case patch

    /**
     *  Indicates a DELETE request.
     */
    case delete
}

// MARK: - Request
/**
 *  An enumeration of the supported request types for making an API request.
 */
enum Request {
    /**
     *  Indicates that the request body is JSON-encoded.
     */
    case jsonEncoding(_ model: [String: Any]?)

    /**
     *  Indicates that the request query parameters are provided as a dictionary.
     */
    case queryString(_ dict: [String: Any]?)

    /**
     *  Indicates that the request body is multipart/form-data.
     */
    case multiPart(_ multiPart: MultipartRequest)

    /**
     *  Indicates that the request body is not encoded.
     */
    case requestPlain

    // MARK: - Internal
    /**
     *  Returns the JSON-encoded body of the request.
     */
    var jsonBody: [String: Any]? {
        switch self {
        case let .jsonEncoding(model):
            return model
        case .queryString, .multiPart, .requestPlain: return nil
        }
    }

    /**
     *  Returns the query parameters of the request.
     */
    var queryItem: [URLQueryItem] {
        switch self {
        case .jsonEncoding, .multiPart, .requestPlain:
            return []
        case let .queryString(dict):
            return dict?.asQueryParam ?? []
        }
    }

    /**
     *  Returns the multipart/form-data of the request.
     */
    var formData: MultipartRequest? {
        switch self {
        case .jsonEncoding, .queryString, .requestPlain: return nil
        case let .multiPart(multiPart):
            return multiPart
        }
    }
}
