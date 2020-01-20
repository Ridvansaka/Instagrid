//
//  PhotoLayoutViewController.swift
//  Instagrid
//
//  Created by SAKA Ridvan on 17/12/2019.
//  Copyright © 2019 SAKA Ridvan. All rights reserved.
//

import UIKit

class PhotoLayoutViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var shareArrowImageView: UIImageView!
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var shareSwipeGestureRecognizer: UISwipeGestureRecognizer!
    
    // MARK: Actions
    
    /// Function that get triggered when swiping up
    /// When triggered, it allows to the user to share the new photo montage on social network or simply saving it intp the photo library. This is done by using the built-in UIActivtyViewController.
    @IBAction func didSwipeOnMainView(_ sender: UISwipeGestureRecognizer) {
        animateGridView(shouldShow: false)
        renderImageAndPresentActivityViewControllerToShare()
    }
    
    /// Button which allows to select the first layout
    @IBAction func didTapLayoutButton(sender: UIButton) {
        handleLayoutButtonTapped(sender: sender)
    }
    
    // MARK: Properties
    
    var selectedImageButton: UIButton?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetLayoutButtonsSelectedImage()
        
        if let layoutButton = layoutButtons.first {
            handleLayoutButtonTapped(sender: layoutButton)
        }
    }
    
    /// Function which is trigerred when device orientation is being changed
    /// It performs all the operations that are necessary in order to make it work in landscape as well as portrait modes
    /// 1. Changing the swipe direction which is necessary to share the photo montage
    /// 2. Change share arrow orientation to point into the swipe direction
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            modifyArrowOrientationForLandscape()
            shareSwipeGestureRecognizer.direction = .left
        } else {
            shareArrowImageView.transform = .identity
            shareSwipeGestureRecognizer.direction = .up
        }
    }
    
    
    // MARK: Private Methods
    
    /// Function that changes the orientation of the arrow according to the orientation of the device
    private func modifyArrowOrientationForLandscape() {
        shareArrowImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    /// Function that create the different views according to layout type
    private func createViewsAccordingTo(layout: Layout) {
        cleanGrid()
        addViewsToStackView(stackView: topStackView, numberOfView: layout.getTopNumber())
        addViewsToStackView(stackView: bottomStackView, numberOfView: layout.getBottomNumber())
    }
    
    /// Function that adds button to a stack view
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
    
    /// Function which get trigerred when tapping on one of the photobutton
    /// It presents the imagePickerController in order to select a photo to add to the layout
    @objc private func didTapOnPhotoButton(sender: UIButton) {
        selectedImageButton = sender
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: {
        })
    }
    
    /// Function that deletes all views previously created in the grid
    private func cleanGrid() {
        for view in topStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for view in bottomStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    /// Function which removes the selection image from the layout buttons
    private func resetLayoutButtonsSelectedImage() {
        for layoutButton in layoutButtons {
            layoutButton.setImage(nil, for: .normal)
        }
    }
    
    /// Function which render the image and present the activityViewController in order to share it
    private func renderImageAndPresentActivityViewControllerToShare() {
        let image = gridView.asImage()
        let items = [image]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.animateGridView(shouldShow: true)
        }
        
        present(activityViewController, animated: true)
    }
    
    /// Function which apply the layout corresponding to the button tag that have been tapped
    private func handleLayoutButtonTapped(sender: UIButton) {
        let layouts = Layout.allCases
        guard sender.tag < layouts.count else { return }
        let layoutSelected = layouts[sender.tag]
        
        resetLayoutButtonsSelectedImage()
        sender.setImage(UIImage(named: "Selected"), for: .normal)
        gridView.isHidden = false
        createViewsAccordingTo(layout: layoutSelected)
    }
    
    /// Function which aninate the main photo layout grid view according to its showing state
    private func animateGridView(shouldShow: Bool) {
        UIView.animate(withDuration: 0.5) {
            if shouldShow {
                self.gridView.transform = .identity
            } else {
                let isLandscape = UIDevice.current.orientation.isLandscape
                
                let translationX = isLandscape ? -self.view.frame.width : 0
                let translationY = isLandscape ? 0 : -self.view.frame.height
                
                self.gridView.transform = CGAffineTransform(translationX: translationX, y: translationY)
            }
        }
    }
}



