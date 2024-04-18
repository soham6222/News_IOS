//
//  ExploreVm.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import Foundation

@MainActor
final class ExploreVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var networkService: NetworkService
    private var output = AppSubject<Output>()
    var arrArtical: [Article] = []
    
    //MARK: - Life-Cycle
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    //MARK: - Enums
    enum Input {
        case getEveryThing(query: String)
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
            case .getEveryThing(let query):
                strongSelf.getNews(query: query)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func getNews(query: String) {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkServices.getEveryThing(model: EveryThingModel(q: query))
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

