//
//  ViewController.swift
//  Instagrid
//
//  Created by SAKA Ridvan on 17/12/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var shareArrowImageView: UIImageView!
    @IBOutlet var layoutButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetLayoutButtonsSelectedImage()
    }
    
    var selectedImageButton: UIButton?
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            modifyArrowOrientationForLandscape()
        } else {
            shareArrowImageView.transform = .identity
        }
    }
    
    private func modifyArrowOrientationForLandscape() {
        shareArrowImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    private func createViewsAccordingTo(layout: Layout) {
        cleanGrid()
        addViewsToStackView(stackView: topStackView, numberOfView: layout.getTopNumber())
        addViewsToStackView(stackView: bottomStackView, numberOfView: layout.getBottomNumber())
    }
    
    private func addViewsToStackView(stackView: UIStackView, numberOfView: Int) {
        for _ in 1...numberOfView {
            let button = UIButton()
            button.backgroundColor = .white
            button.setImage(UIImage(named: "Plus"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(didTapOnPhotoButton(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapOnPhotoButton(sender: UIButton) {

        selectedImageButton = sender
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: {
        })
    }
    
    
    @IBAction func didSwipeOnMainView(_ sender: UISwipeGestureRecognizer) {
        let image = gridView.asImage()
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func resetLayoutButtonsSelectedImage() {
        for layoutButton in layoutButtons {
            layoutButton.setImage(nil, for: .normal)
        }
    }
    
    @IBAction func didTapFirstButton(sender: UIButton) {
        resetLayoutButtonsSelectedImage()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
        gridView.isHidden = false
        createViewsAccordingTo(layout: .OneTopTwoBottom)
    }
    
    @IBAction func didTapSecondButton(sender: UIButton) {
        resetLayoutButtonsSelectedImage()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
        gridView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopOneBottom)
    }
    
    @IBAction func didTapThirdButton(sender: UIButton) {
        resetLayoutButtonsSelectedImage()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
        gridView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopTwoBottom)
    }
    
    private func cleanGrid() {
        for view in topStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for view in bottomStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
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

extension ViewController: UINavigationControllerDelegate {
    
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
