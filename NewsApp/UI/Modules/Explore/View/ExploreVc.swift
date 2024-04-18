//
//  ExploreVc.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

final class ExploreVc: ViewController<ExploreVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvExplore: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<ExploreVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExploreVm()
        bindViewModel()
        input.send(.getEveryThing(query: "tesla"))
    }
    
    override func setUi() {
        super.setUi()
        
        clvExplore.delegate = self
        clvExplore.dataSource = self
        clvExplore.register(R.nib.searchCell)
        clvExplore.register(R.nib.newsCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case .newsGet:
                strongSelf.clvExplore.reloadSection(section: 1)
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return AppLayout.shared.profileSection()
            case 1: return AppLayout.shared.profileSection()
            default: return AppLayout.shared.profileSection()
            }
        }
        clvExplore.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ExploreVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel?.arrArtical.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: SearchCell = clvExplore.deque(indexPath: indexPath)
            cell.publisher.debounce(for: 1, scheduler: queue).weekSink(self) { strongSelf, event in
                switch event {
                case let .search(text):
                    strongSelf.input.send(.getEveryThing(query: text.lowercased()))
                }
            }.store(in: &cell.bag)
            return cell
        case 1:
            let cell: NewsCell = clvExplore.deque(indexPath: indexPath)
            cell.model = viewModel?.arrArtical[indexPath.row]
            return cell
        default: return .init()
        }
    }
}
