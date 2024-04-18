//
//  Extention+Uilable.swift
//  BodyRx
//
//  Created by user238596 on 10/04/24
//

import UIKit

extension UILabel {
    func halfTextColorChange(fullText: String, changeText: String, color: UIColor = .gray, font: UIFont?) {
        let strNumber: NSString = fullText as NSString
        let range = strNumber.range(of: changeText)
        let attribute = NSMutableAttributedString(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attribute.addAttribute(NSAttributedString.Key.font,
                               value: font ?? UIFont.systemFont(ofSize: 14, weight: .bold),
                               range: range)
        attributedText = attribute
    }
}
