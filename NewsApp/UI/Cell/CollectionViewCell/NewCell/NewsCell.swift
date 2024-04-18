//
//  NewsCell.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

final class NewsCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblAutherName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //MARK: - Properties
    var model: Article? {
        didSet {
            loadData()
        }
    }
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func loadData() {
        guard let model = model else { return }
        
        imgContent.setImage(from: model.urlToImage ?? "")
        lblAutherName.text = model.author
        lblTitle.text = model.title
        lblPublisher.text = model.source?.name
    }
}
