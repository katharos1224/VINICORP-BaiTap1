//
//  ButtonViewController.swift
//  BaiTap1
//
//  Created by Katharos on 27/10/2023.
//

import UIKit

final class ButtonViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var changeColorButton: CustomButton!
    @IBOutlet weak var countButton: CustomButton!
    
    @IBOutlet weak var validatedEmailLabel: UILabel!
    @IBOutlet weak var validatedNumberLabel: UILabel!
    @IBOutlet weak var validatedAuthLabel: UILabel!
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var numberField: CustomTextField!
    @IBOutlet weak var usernameField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    private var toggleButton: UIButton = {
        let toggleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        toggleButton.tintColor = .systemGreen
        return toggleButton
    }()
    
    private var count: Int = 0
    private var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addObservableKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideValidatedLabels()
    }
    
    private func hideValidatedLabels() {
        validatedEmailLabel.isHidden = true
        validatedNumberLabel.isHidden = true
        validatedAuthLabel.isHidden = true
    }
    
    private func configureUI() {
        title = "Button"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(toggleButton)
        passwordField.rightView = paddingView
        passwordField.rightViewMode = .always
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    @objc func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordField.isSecureTextEntry = !isPasswordVisible
        
        let image = isPasswordVisible ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        toggleButton.setImage(image, for: .normal)
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
    
    @IBAction func didTapChangeColor() {
        changeColorButton.backgroundColor = .randomColor
    }
    
    @IBAction func didTapCountButton() {
        count += 1
        countButton.setTitle("Count Button + \(count)", for: .normal)
    }
    
    @IBAction func didTapCheckEmail() {
        guard let email = emailField.text, isValidEmail(email) == .validEmail else {
            validatedEmailLabel.text = "\(ValidFormat.invalidEmail.rawValue)"
            validatedEmailLabel.textColor = .systemRed
            validatedEmailLabel.isHidden = false
            return
        }
        validatedEmailLabel.text = "\(isValidEmail(email).rawValue)"
        validatedEmailLabel.textColor = .systemGreen
        validatedEmailLabel.isHidden = false
    }
    
    @IBAction func didTapCheckNumber() {
        guard let number = numberField.text, isValidNumber(number) == .validNumber else {
            validatedNumberLabel.text = "\(ValidFormat.invalidNumber.rawValue)"
            validatedNumberLabel.textColor = .systemRed
            validatedNumberLabel.isHidden = false
            return
        }
        validatedNumberLabel.text = "\(isValidNumber(number).rawValue)"
        validatedNumberLabel.textColor = .systemGreen
        validatedNumberLabel.isHidden = false
    }
    
    @IBAction func didTapLogin() {
        guard let username = usernameField.text, let password = passwordField.text, username != "" || password != "" else {
            validatedAuthLabel.text = "Enter all informations please!"
            validatedAuthLabel.isHidden = false
            return
        }
        
        let usernameResult = isValidUsername(username)
        let passwordResult = isValidPassword(password)
        
        if usernameResult == .validUsername && passwordResult == .validPasswords {
            validatedAuthLabel.text = "Login successful!"
            validatedAuthLabel.textColor = .systemGreen
        } else {
            validatedAuthLabel.text = "Invalid username or password!"
            validatedAuthLabel.textColor = .systemRed
        }
        
        validatedAuthLabel.isHidden = false
    }
}

extension ButtonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
