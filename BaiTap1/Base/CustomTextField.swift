//
//  CustomTextField.swift
//  BaiTap1
//
//  Created by Katharos on 30/10/2023.
//


import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.borderStyle = .none
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemGreen.cgColor
        self.layer.cornerRadius = 10
        
        setLeftPadding()
    }
    
    private func setLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

