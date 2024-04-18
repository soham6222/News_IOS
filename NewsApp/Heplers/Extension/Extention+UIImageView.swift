//
//  Extention+UIImageView.swift
//  Squeezee
//
//  Created by user238596 on 10/04/24
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(from urlStr: String, placeholderImage: UIImage = UIImage(), complition: ((UIImage) -> Void)? = nil) {
        guard let url = URL(string: urlStr) else {
            return
        }
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .transition(.fade(1)),
                .processor(DefaultImageProcessor()),
                .cacheOriginalImage,
                .scaleFactor(UIScreen.main.scale)
            ]
        ) { result in
            switch result {
            case let .success(value):
                complition?(value.image)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }

    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
    
    func imageWith() {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        var initials = ""
        let initialsArray = UserDefaults.userName.components(separatedBy: " ")
        if let firstWord = initialsArray.first {
            if let firstLetter = firstWord.first { initials += String(firstLetter).capitalized }
        }
        if initialsArray.count > 1, let lastWord = initialsArray.last {
            if let lastLetter = lastWord.first { initials += String(lastLetter).capitalized }
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            self.image = nameImage
        }
    }
}
