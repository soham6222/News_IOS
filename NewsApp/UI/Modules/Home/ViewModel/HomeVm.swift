//
//  HomeVm.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import Foundation

@MainActor
final class HomeVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var output = AppSubject<Output>()
    var selectedTagIndex: Int = 0
    let arrTag = ["Business", "Technology", "Health", "Science"]
    var arrArtical: [Article] = []
    
    //MARK: - Enums
    enum Input {
        case getNews
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
        case newsGet
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .getNews:
                strongSelf.getNews()
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func getNews() {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkServices.getTopHeadLine(model: HeadLinePostModel(country: "us", category: arrTag[selectedTagIndex].lowercased()))
                arrArtical = model.articles ?? []
                output.send(.loader(isLoading: false))
                output.send(.newsGet)
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.localizedDescription))
            }
        }.store(in: &taskBag)
    }
}

