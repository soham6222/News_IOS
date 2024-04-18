//
//  NewsReponseModel.swift
//  BoilerPlate
//
//  Created by user238596 on 10/04/24
//

import Foundation

// MARK: - EveryThingModel
struct EveryThingModel: Codable {
    let q: String?
    var from: String? {
        let date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        return date.toString(format: .yyyyMMdd)
    }
    var sortBy: String? = "publishedAt"
    var apiKey: String = API_KEY
}

// MARK: - HeadLinePostModel
struct HeadLinePostModel: Codable {
    let country: String?
    let category: String?
    var apiKey: String = API_KEY
}

// MARK: - NewsReponseModel
struct NewsReponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
