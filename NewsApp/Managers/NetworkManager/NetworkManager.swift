//
//  NetworkManager.swift
//  Squeezee
//
//  Created by user238596 on 10/04/24
//

import Foundation

final class NetworkManager: NetworkService {
    func getTopHeadLine(model: HeadLinePostModel) async throws -> NewsReponseModel {
        return try await APIService.request(API.topHeadlines(model: model))
    }
    
    func getEveryThing(model: EveryThingModel) async throws -> NewsReponseModel {
        return try await APIService.request(API.everyThing(model: model))
    }
}
