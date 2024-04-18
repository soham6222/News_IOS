//
//  API.swift
//  Squeezee
//
//  Created by user238596 on 10/04/24
//

import Foundation

// MARK: - API
enum API {
    case topHeadlines(model: HeadLinePostModel)
    case everyThing(model: EveryThingModel)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        case .everyThing:
            return "everything"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .topHeadlines, .everyThing:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case let .topHeadlines(model):
            return .queryString(model.asDictionary)
        case let .everyThing(model):
            return .queryString(model.asDictionary)
        }
    }
    
    var header: [String: String] {
        switch self {
        case .topHeadlines, .everyThing:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
}
