//
//  CustomButton.swift
//  BaiTap1
//
//  Created by Katharos on 27/10/2023.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.tintColor = UIColor.secondarySystemBackground
        self.backgroundColor = UIColor.systemIndigo
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
