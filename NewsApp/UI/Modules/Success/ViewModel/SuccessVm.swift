//
//  SuccessVm.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import Foundation

final class SuccessVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var output = AppSubject<Output>()
    
    //MARK: - Enums
    enum Input {
        case didTapGotoHome
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .didTapGotoHome:
                strongSelf.router.setRoot(to: .tab, duration: 0.3, options: .transitionCrossDissolve)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
}

