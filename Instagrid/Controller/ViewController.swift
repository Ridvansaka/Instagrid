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
    @IBOutlet weak var firstButtonView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func createViewsAccordingTo(layout: Layout) {
        //        cleanGrid()
        addViewsToStackView(stackView: topStackView, number: layout.getTopNumber())
        addViewsToStackView(stackView: bottomStackView, number: layout.getBottomNumber())
    }
    
    private func addViewsToStackView(stackView: UIStackView, number: Int) {
        for _ in 1...number {
            let button = UIButton()
            button.backgroundColor = .black
            stackView.addArrangedSubview(button)
        }
    }
    
    @IBAction func didTapFirstButton() {
        firstButtonView.isHidden = false
        createViewsAccordingTo(layout: .OneTopTwoBottom)
    }
    
    @IBAction func didTapSecondButton() {
        firstButtonView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopOneBottom)
    }
    
    @IBAction func didTapThirdButton() {
        firstButtonView.isHidden = false
        createViewsAccordingTo(layout: .TwoTopTwoBottom)
    }
    
    private func cleanGrid() {
//        for view in topStackView.arrangedSubviews {
//            view.removeFromSuperview()
//        }
//        for view in bottomStackView.arrangedSubviews {
//            view.removeFromSuperview()
//        }
    }
}

