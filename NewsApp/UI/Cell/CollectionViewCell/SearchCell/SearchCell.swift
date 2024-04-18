//
//  SearchCell.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

enum SearchCellEvent {
    case search(text: String)
}

final class SearchCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtSearch: UITextField!
    
    //MARK: - Properties
    var bag = Bag()
    var subJect = AppSubject<SearchCellEvent>()
    var publisher: AppAnyPublisher<SearchCellEvent> {
        subJect.eraseToAnyPublisher()
    }
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtSearch.addTarget(self, action: #selector(search(_ :)), for: .editingChanged)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = Bag()
    }
    
    //MARK: - @IBActions
    @objc
    func search(_ textField: UITextField) {
        subJect.send(.search(text: textField.text ?? ""))
    }
    
    //MARK: - Functions
}
