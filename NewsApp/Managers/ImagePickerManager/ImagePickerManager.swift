//
//  ImagePickerManager.swift
//  Summit
//
//  Created by user238596 on 10/04/24
//

import UIKit

// MARK: - PickingOption
enum PickingOption {
    case camera
    case photos
}

// MARK: - ImagePickerManager
final class ImagePickerManager: NSObject {
    private var imagePicker = UIImagePickerController()
    private var viewController: UIViewController?
    private var didFinishPickingMedia: ((UIImage) -> Void)?
    private var pickerTypes: [PickingOption] = [.photos]

    static let shared = ImagePickerManager()

    override private init() {
        super.init()
    }

    private func configureAndShowAlerts() {
        let pickerAlert = UIAlertController(title: "Choose image from",
                                            message: nil,
                                            preferredStyle:
                                            UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
        if pickerTypes.contains(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.openCamera()
            }
            pickerAlert.addAction(cameraAction)
        }

        if pickerTypes.contains(.photos) {
            let photosAction = UIAlertAction(title: "Photos", style: .default) { _ in
                self.openPhotos()
            }
            pickerAlert.addAction(photosAction)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        pickerAlert.addAction(cancelAction)

        viewController?.present(pickerAlert, animated: true, completion: nil)
    }

    func pickImage(on viewController: UIViewController,
                   withOption: [PickingOption],
                   _ didFinishPickingMedia: @escaping ((UIImage) -> Void)) {
        self.didFinishPickingMedia = didFinishPickingMedia
        pickerTypes = withOption
        self.viewController = viewController
        imagePicker.delegate = self
        if withOption.count == 1 {
            if withOption.first == .camera {
                openCamera()
            }
            if withOption.first == .photos {
                openPhotos()
            }
            return
        }
        configureAndShowAlerts()
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            viewController?.present(imagePicker, animated: true, completion: nil)
        } else {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: "No camera available.")
        }
    }

    private func openPhotos() {
        imagePicker.sourceType = .photoLibrary
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        didFinishPickingMedia?(image)
    }
}
