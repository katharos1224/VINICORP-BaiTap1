//
//  UIColor+Extensions.swift
//  BaiTap1
//
//  Created by Katharos on 01/11/2023.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
