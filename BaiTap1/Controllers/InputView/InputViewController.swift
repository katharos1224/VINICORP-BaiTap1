//
//  InputViewController.swift
//  BaiTap1
//
//  Created by Katharos on 27/10/2023.
//

import UIKit

final class InputViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var leftPaddingField: CustomTextField!
    @IBOutlet weak var rightPaddingField: CustomTextField!
    @IBOutlet weak var topPaddingField: CustomTextField!
    @IBOutlet weak var bottomPaddingField: CustomTextField!
    @IBOutlet weak var botCenPaddingField: CustomTextField!
    @IBOutlet weak var topRightPaddingField: CustomTextField!
    @IBOutlet weak var topCenPaddingField: CustomTextField!
    
    @IBOutlet weak var leftImageField: CustomTextField!
    @IBOutlet weak var rightImageField: CustomTextField!
    @IBOutlet weak var topImageField: CustomTextField!
    @IBOutlet weak var bottomImageField: CustomTextField!
    
    private var leftImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(systemName: "x.circle.fill")
        imageView.tintColor = .systemRed
        imageView.contentMode = .center
        imageView.center = CGPoint(x: 20, y: 15)
        return imageView
    }()
    
    private var rightImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(systemName: "x.circle.fill")
        imageView.tintColor = .systemRed
        imageView.contentMode = .center
        imageView.center = CGPoint(x: 0, y: 15)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addObservableKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    private func addObservableKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureUI() {
        title = "Input"
        
        // Left:
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: leftPaddingField.frame.height))
        leftPaddingField.leftView = leftPaddingView
        leftPaddingField.leftViewMode = .always
        
        // Right:
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: rightPaddingField.frame.height))
        rightPaddingField.rightView = rightPaddingView
        rightPaddingField.rightViewMode = .always
        
        // Left with Image:
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        leftView.addSubview(leftImageView)
        
        leftImageField.leftView = leftView
        leftImageField.leftViewMode = .always
        
        // Right with Image:
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        rightView.addSubview(rightImageView)
        
        rightImageField.rightView = rightView
        rightImageField.rightViewMode = .always
        
        // Top:
        
        // Bottom:
        
        // Top with Image:
        
        // Bottom with Image:
        
    }
    
}

extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
