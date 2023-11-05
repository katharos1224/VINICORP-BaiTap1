//
//  TextViewController.swift
//  BaiTap1
//
//  Created by Katharos on 27/10/2023.
//

import UIKit

final class TextViewController: BaseViewController {
    
    @IBOutlet weak var strikeThroughLabel: UILabel!
    @IBOutlet weak var underLineLabel: UILabel!
    @IBOutlet weak var testStrikeLabel: UILabel!
    @IBOutlet weak var roundedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        title = "Text"
        
        let strikeThroughString: NSMutableAttributedString =  NSMutableAttributedString(string: "ô text gạch ngang giữa")
        
        strikeThroughString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, strikeThroughString.length))
        strikeThroughLabel.attributedText = strikeThroughString
        
        let underlineString: NSMutableAttributedString =  NSMutableAttributedString(string: "ô text gạch dưới")
        
        underlineString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, underlineString.length))
        underLineLabel.attributedText = underlineString
        
        let testStrikeString = "This is a test strike"
        let attributedString = NSMutableAttributedString(string: testStrikeString)
        
        let nsString = testStrikeString as NSString
        let rangeThis = nsString.range(of: "This")
        
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: rangeThis.location, length: rangeThis.length))
        testStrikeLabel.attributedText = attributedString
        
        roundedLabel.backgroundColor = .systemRed
        roundedLabel.layer.cornerRadius = 10
        roundedLabel.clipsToBounds = true
    }
}
