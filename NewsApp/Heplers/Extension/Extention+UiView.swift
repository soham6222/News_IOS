//
//  Extention+UiView.swift
//  Summit
//
//  Created by user238596 on 10/04/24
//

import UIKit

public extension UIView {
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else {
                return
            }
            layer.borderColor = color.cgColor
        }
    }

    @IBInspectable var layerBorderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    var height: CGFloat {
        get {
            frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    var isRightToLeft: Bool {
        effectiveUserInterfaceLayoutDirection == .rightToLeft
    }

    var screenshot: UIImage? {
        let size = layer.frame.size
        guard size != .zero else {
            return nil
        }
        return UIGraphicsImageRenderer(size: layer.frame.size).image { context in
            layer.render(in: context.cgContext)
        }
    }

    @IBInspectable var layerShadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var layerShadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var layerShadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var layerShadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var masksToBounds: Bool {
        get {
            layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    var size: CGSize {
        get {
            frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    var width: CGFloat {
        get {
            frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var xPosition: CGFloat {
        get {
            frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    var yPosition: CGFloat {
        get {
            frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
}

// MARK: - UIView.GradientDirection
public extension UIView {
    struct GradientDirection {
        // MARK: - Lifecycle
        public init(startPoint: CGPoint, endPoint: CGPoint) {
            self.startPoint = startPoint
            self.endPoint = endPoint
        }

        // MARK: - Public
        public static let topToBottom = GradientDirection(startPoint: CGPoint(x: 0.5, y: 0.0),
                                                          endPoint: CGPoint(x: 0.5, y: 1.0))
        public static let bottomToTop = GradientDirection(startPoint: CGPoint(x: 0.5, y: 1.0),
                                                          endPoint: CGPoint(x: 0.5, y: 0.0))
        public static let leftToRight = GradientDirection(startPoint: CGPoint(x: 0.0, y: 0.5),
                                                          endPoint: CGPoint(x: 1.0, y: 0.5))
        public static let rightToLeft = GradientDirection(startPoint: CGPoint(x: 1.0, y: 0.5),
                                                          endPoint: CGPoint(x: 0.0, y: 0.5))

        public let startPoint: CGPoint
        public let endPoint: CGPoint
    }
}

extension UIView {
    func addGradient(colors: [UIColor], locations: [CGFloat] = [0.0, 1.0], direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.locations = locations.map { NSNumber(value: $0) }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        layer.addSublayer(gradientLayer)
    }

    func addShadow(ofColor color: UIColor = .gray,
                   radius: CGFloat = 3,
                   offset: CGSize = .zero,
                   opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        superview as? T ?? superview.map { $0.superview(of: type)! }
    }

    func subview<T>(of type: T.Type) -> T? {
        subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}

extension UIView {
    @discardableResult
    func loadFromNib<T: UIView>() -> T? {
        let bundle = Bundle(for: type(of: self))
        let loadedView = bundle.loadNibNamed(String(describing: type(of: self)),
                                             owner: self,
                                             options: nil)?.first
        guard let contentView = loadedView as? T else {
            return nil
        }
        return contentView
    }

    func fixInView(_ container: UIView, with padding: CGFloat = 0) {
        frame = container.bounds
        container.addSubview(self)
        addEqualConstraintsWith(container, with: padding)
    }

    func addEqualConstraintsWith(_ view: UIView, with constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        ])
    }
}
