//
//  WelcomeViewController.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import UIKit
import Firebase

protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerDidLoginSuccessfully(_ controller: WelcomeViewController)
}

class WelcomeViewController: ViewController {
    
    private let titleView = UILabel()
    private let googleLoginButton = TextButton(frame: .zero, buttonType: .primary)
    
    var viewModel: AuthenticationViewModel? {
        didSet {
            
        }
    }
    weak var delegate: WelcomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGestures()
        configureConstraints()
    }
    
    enum SignInState {
        case signedIn
        case signedOut
      }
}
// MARK: - Actions
extension WelcomeViewController {
    private func didTapGoogleLogin() {
        viewModel?.signIn()
    }
}
// MARK: - View Config
extension WelcomeViewController {
    private func configureViews() {
        titleView.text = "MuFitnessGal"
        titleView.font = UIFont.h2
        titleView.textColor = UIColor.label
        view.addSubview(titleView)
        
        googleLoginButton.tapHandler = {[weak self] in
            self?.didTapGoogleLogin()
        }
        googleLoginButton.text = "Continue with Google"
        view.addSubview(googleLoginButton)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        titleView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        googleLoginButton.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
}
