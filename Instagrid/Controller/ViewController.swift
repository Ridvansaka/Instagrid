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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapFirstButton() {
         firstButtonView.isHidden = false
    }
    
    @IBAction func didTapSecondButton() {
        firstButtonView.isHidden = true
    }
    
    @IBAction func didTapThirdButton() {
        firstButtonView.isHidden = false
    }
}

