//
//  PhotoLayoutViewController+UIImagePickerControllerDelegate.swift
//  Instagrid
//
//  Created by SAKA Ridvan on 20/01/2020.
//  Copyright © 2020 SAKA Ridvan. All rights reserved.
//

import UIKit

// MARK: UIImagePickerControllerDelegate

extension PhotoLayoutViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let button = selectedImageButton {
                button.imageView?.contentMode = .scaleAspectFill
                button.setImage(pickedImage, for: .normal)
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
