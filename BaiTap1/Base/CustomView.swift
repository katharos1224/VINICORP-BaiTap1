//
//  CustomView.swift
//  BaiTap1
//
//  Created by Katharos on 28/10/2023.
//

import UIKit

class CustomView: UIView {
    var borderRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .secondarySystemBackground
    }
}
