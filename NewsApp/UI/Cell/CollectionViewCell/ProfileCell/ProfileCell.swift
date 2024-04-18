//
//  ProfileCell.swift
//  NewsApp
//
//  Created by user238596 on 10/04/24
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    //MARK: - Properties
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        setData()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonEditProfile(_ sender: Any) {
    }
    
    @IBAction func didTapButtonWebsite(_ sender: Any) {
    }
    
    //MARK: - Functions
    private func setData() {
        imgProfile.imageWith()
        lblName.text = UserDefaults.userName
    }
}
