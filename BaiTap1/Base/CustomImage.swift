//
//  CustomImage.swift
//  BaiTap1
//
//  Created by Katharos on 01/11/2023.
//

import UIKit

class CustomImage: UIImageView {

    var hasBorder: Bool = false {
        didSet {
            updateBorder()
        }
    }
    
    var hasShadow: Bool = false {
        didSet {
            updateShadow()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    override var bounds: CGRect {
        didSet {
            updateBorder()
            updateShadow()
        }
    }

    private func updateBorder() {
        layer.borderWidth = hasBorder ? 10.0 : 0.0
        layer.borderColor = hasBorder ? UIColor.green.cgColor : nil
        updateShadow()
    }
    
    private func updateShadow() {
        layer.shadowColor = hasShadow ? UIColor.black.cgColor : UIColor.clear.cgColor
        layer.shadowOpacity = hasShadow ? 0.5 : 0.0
        layer.shadowOffset = hasShadow ? CGSize(width: 2, height: 2) : CGSize.zero
        layer.shadowRadius = hasShadow ? 4 : 0
        layer.masksToBounds = !hasShadow
        
        if hasShadow {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        } else {
            layer.shadowPath = nil
        }
    }
}




