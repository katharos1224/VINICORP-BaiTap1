//
//  MenuViewController.swift
//  BaiTap1
//
//  Created by Katharos on 27/10/2023.
//

import UIKit

final class MenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
    }
    
    @IBAction func didTapTextView() {
        push(vc: TextViewController())
    }
    
    @IBAction func didTapInputView() {
        push(vc: InputViewController())
    }
    
    @IBAction func didTapButtonView() {
        push(vc: ButtonViewController())
    }
    
    @IBAction func didTapLayout() {
        push(vc: LayoutViewController())
    }
    
    @IBAction func didTapCasino() {
        push(vc: GameViewController())
    }
}
