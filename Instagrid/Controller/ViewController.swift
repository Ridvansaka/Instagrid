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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func createViewsAccordingTo(layout: Layout) {
        cleanGrid()
        addViewsToStackView(stackView: topStackView, number: layout.getTopNumber())
        addViewsToStackView(stackView: bottomStackView, number: layout.getBottomNumber())
    }
    
    private func addViewsToStackView(stackView: UIStackView, number: Int) {
        for _ in 1...number {
            let button = UIButton()
            button.backgroundColor = .white
            button.setImage(UIImage(named: "Plus"), for: .normal)
            button.addTarget(self, action: #selector(didTapOnPhotoButton), for: .touchUpInside )
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapOnPhotoButton() {
    }
    
    @IBAction func didTapFirstButton() {
        gridView.isHidden = false
        createViewsAccordingTo(layout: .OneTopTwoBottom)
    }
    
    @IBAction func didTapSecondButton() {
        gridView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopOneBottom)
    }
    
    @IBAction func didTapThirdButton() {
        gridView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopTwoBottom)
    }
    
    private func cleanGrid() {
        for view in topStackView.arrangedSubviews {
            topStackView.removeArrangedSubview(view)
        }
        for view in bottomStackView.arrangedSubviews {
            bottomStackView.removeArrangedSubview(view)
        }
    }
}

