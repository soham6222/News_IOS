//
//  HomeVc.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

final class HomeVc: ViewController<HomeVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvHome: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<HomeVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeVm()
        bindViewModel()
        input.send(.getNews)
    }
    
    override func setUi() {
        super.setUi()
        
        clvHome.delegate = self
        clvHome.dataSource = self
        clvHome.register(R.nib.tagCell)
        clvHome.register(R.nib.newsCell)
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
                strongSelf.clvHome.reloadSection(section: 1)
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return AppLayout.shared.tagSection()
            case 1: return AppLayout.shared.profileSection()
            default: return AppLayout.shared.profileSection()
            }
        }
        clvHome.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel?.arrTag.count ?? 0
        case 1: return viewModel?.arrArtical.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: TagCell = clvHome.deque(indexPath: indexPath)
            cell.lblTag.text = viewModel?.arrTag[indexPath.row]
            if viewModel?.selectedTagIndex == indexPath.row {
                cell.lblTag.textColor = .white
                cell.viewBg.backgroundColor = R.color.color_1877F2()
            } else {
                cell.lblTag.textColor = R.color.color_1877F2()
                cell.viewBg.backgroundColor = .clear
            }
            return cell
        case 1:
            let cell: NewsCell = clvHome.deque(indexPath: indexPath)
            cell.model = viewModel?.arrArtical[indexPath.row]
            return cell
        default: return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            viewModel?.selectedTagIndex = indexPath.row
            clvHome.reloadSection(section: 0)
            input.send(.getNews)
        default: break
        }
    }
}
