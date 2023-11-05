//
//  BaseViewController.swift
//  BaiTap1
//
//  Created by Katharos on 30/10/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func push(vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.popViewController(animated: animated)
    }
    
    func show(vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(vc, animated: animated)
    }
    
    func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: animated)
    }
    
    func showAlert(alertTitle: String, actionTitle: String, message: String) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(_ input: String) -> ValidFormat {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: input) ? .validEmail : .invalidEmail
    }
    
    func isValidNumber(_ input: String) -> ValidFormat {
        let numberRegex = "^[0-9]+$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return numberPredicate.evaluate(with: input) ? .validNumber : .invalidNumber
    }
    
    func isValidUsername(_ username: String) -> ValidFormat {
        let usernameRegex = "^[0-9]{1,10}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        
        return usernamePredicate.evaluate(with: username) ? .validUsername : .invalidUsername
    }
    
    func isValidPassword(_ password: String) -> ValidFormat {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,16}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password) ? .validPasswords : .invalidPasswords
    }
}

enum ValidFormat: String {
    case validEmail = "Valid email format."
    case invalidEmail = "Invalid email format."
    case validNumber = "Valid numbers format."
    case invalidNumber = "Invalid numbers format."
    case validPasswords = "Valid passwords format."
    case invalidPasswords = "Invalid passwords format."
    case validUsername = "Valid username format."
    case invalidUsername = "Invalid username format."
}
