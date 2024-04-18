//
//  NetworkService.swift
//  Squeezee
//
//  Created by user238596 on 10/04/24//

import Foundation

protocol NetworkService {
    func getTopHeadLine(model: HeadLinePostModel) async throws -> NewsReponseModel
    
    func getEveryThing(model: EveryThingModel) async throws -> NewsReponseModel
}
