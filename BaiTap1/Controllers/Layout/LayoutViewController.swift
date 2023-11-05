//
//  LayoutViewController.swift
//  BaiTap1
//
//  Created by Katharos on 31/10/2023.
//

import UIKit

final class LayoutViewController: BaseViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var borderedImage: CustomImage!
    
    @IBOutlet weak var firstButton: CustomButton!
    @IBOutlet weak var secondButton: CustomButton!
    @IBOutlet weak var thirdButton: CustomButton!
    @IBOutlet weak var fourthButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [self] context in
            let buttons: [CustomButton] = [firstButton, secondButton, thirdButton, fourthButton]
            buttons.forEach { $0.layer.cornerRadius = $0.frame.size.height / 2 }
        }, completion: nil)
    }
    
    private func configureUI() {
        title = "Layout"
        
        borderedImage.hasBorder = true
    }
    
    private func selectButton(_ selectedButton: UIButton) {
        let buttons: [CustomButton] = [firstButton, secondButton, thirdButton, fourthButton]
        buttons.forEach { $0.backgroundColor = $0 == selectedButton ? .randomColor : .systemIndigo }
    }
    
    @IBAction func didTapFirstButton(_ sender: CustomButton) {
        selectButton(sender)
    }
    
    @IBAction func didTapSecondButton(_ sender: CustomButton) {
        selectButton(sender)
    }
    
    @IBAction func didTapThirdButton(_ sender: CustomButton) {
        selectButton(sender)
    }
    
    @IBAction func didTapFourthButton(_ sender: CustomButton) {
        selectButton(sender)
    }
}

extension LayoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        label.text = textField.text != "" ? textField.text : "Vinicorp"
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        label.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        return true
    }
}
