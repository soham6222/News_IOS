//
//  MainVc.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import UIKit

// MARK: - MainVc
final class MainVc: ViewController<MainVm> {
    // MARK: - @IBOutlets
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblHaveAnAccount: UILabel!
    
    // MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<MainVm.Input>()

    // MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MainVm()
        bindViewModel()
    }

    override func setUi() {
        super.setUi()
        
        lblHaveAnAccount.halfTextColorChange(fullText: lblHaveAnAccount.text!,
                                                changeText: "Login",
                                                color: R.color.color_1877F2() ?? .blue,
                                             font: .systemFont(ofSize: 14, weight: .bold))
        lblHaveAnAccount.isUserInteractionEnabled = true
        lblHaveAnAccount.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
    }

    // MARK: - @IBActions
    @IBAction func didTapButtonSignUp(_ sender: Any) {
        do {
            let validation = try validate()
            UserDefaults.userName = validation.userName
            input.send(.didTapSignUp)
        } catch let error as ValidationError {
            showAlert(msg: error.description)
        } catch {
            showAlert(msg: error.localizedDescription)
        }
    }
    
    @IBAction func didTapButtonRememberMe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.isRemember = sender.isSelected
    }
    
    @IBAction func didTapButtonFaceBook(_ sender: Any) {
        showAlert(msg: ALERT_TEXT)
    }
    
    @IBAction func didTapButtonGoogle(_ sender: Any) {
        showAlert(msg: ALERT_TEXT)
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        let range = (lblHaveAnAccount.text! as NSString).range(of: "Login")

        if recognizer.didTapAttributedTextInLabel(label: lblHaveAnAccount, inRange: range) {
            showAlert(msg: ALERT_TEXT)
        } else {
            return
        }
    }
    
    // MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            }
        }.store(in: &disposeBag)
    }
    
    private func validate() throws -> (userName: String, password: String) {
        guard let userName = txtUserName.text, !userName.isEmpty else {
            throw ValidationError.empty(type: "User Name")
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            throw ValidationError.empty(type: "Password")
        }
        
        guard let password = txtPassword.text, password.isValidPassword else {
            throw ValidationError.inValidPassword
        }
        
        return (userName, password)
    }
}
