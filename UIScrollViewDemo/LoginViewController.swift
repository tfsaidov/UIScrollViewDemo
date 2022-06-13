//
//  LoginViewController.swift
//  UIScrollViewDemo
//
//  Created by Саидов Тимур on 07.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = 0
        textField.placeholder = "Введите логин"
        textField.keyboardType = .phonePad
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = 1
        textField.placeholder = "Введите пароль"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var login: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupGestures()
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.loginTextField)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.stackView.addArrangedSubview(self.button)
        let scrollViewConstraints = self.scrollViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        NSLayoutConstraint.activate(
            scrollViewConstraints +
            stackViewConstraints
        )
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingAnchor = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: 180)
        
        return [
            centerYConstraint, leadingConstraint, trailingConstraint, heightConstraint
        ]
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.stackView.frame.origin.y + self.button.frame.origin.y + self.button.frame.height // self.button.frame.origin.y - положение относительно супервью - self.stackView - поэтому прибавляем положение стека.
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0

            print("🍋 \(self.stackView.frame.origin.y), \(self.loginTextField.frame.origin.y), \(self.button.frame.origin.y)")
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("🍋 \(textField.text)")
        if textField.tag == 0 {
            self.login = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.forcedHidingKeyboard()
        return true
    }
}
