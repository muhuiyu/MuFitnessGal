//
//  ImageTitleButtonViewController.swift
//  Intellect prototype
//
//  Created by Mu Yu on 18/2/21.
//

import UIKit

class ImageTitleButtonViewController: ViewController {
    
    private let headerContainer = HeaderWithLargeTitleView()
    private let illustationImageView = UIImageView()
    private let bottomButton = TextButton(buttonType: .primary)
    private let topButton = TextButton(buttonType: .primary)
    
    var titleText: String? {
        get { return headerContainer.text }
        set { headerContainer.text = newValue }
    }
    var subtitleText: String? {
        get { return headerContainer.subtitle }
        set { headerContainer.subtitle = newValue }
    }
    var image: UIImage? {
        get { return illustationImageView.image }
        set { illustationImageView.image = newValue }
    }
    var buttonLayout: ButtonsLayout {
        didSet {
            configureButtons()
        }
    }
    enum ButtonsLayout {
        case twoButtons
        case singleButton
        case noButton
    }
    var bottomButtonType: TextButton.ButtonType? {
        get { return bottomButton.buttonType }
        set { bottomButton.buttonType = newValue ?? .primary }
    }
    var topButtonType: TextButton.ButtonType? {
        get { return topButton.buttonType }
        set { topButton.buttonType = newValue ?? .primary }
    }
    var bottomButtonText: String? {
        get { return bottomButton.text }
        set { bottomButton.text = newValue }
    }
    var topButtonText: String? {
        get { return topButton.text }
        set { topButton.text = newValue }
    }
    var topTapHandler: (() -> Void)? {
        didSet {
            topButton.tapHandler = topTapHandler
        }
    }
    var bottomTapHandler: (() -> Void)? {
        didSet {
            bottomButton.tapHandler = bottomTapHandler
        }
    }
    
    let isNavigationBarHidden: Bool
    init(isNavigationBarHidden: Bool = false, buttonLayout: ButtonsLayout = .noButton) {
        self.isNavigationBarHidden = isNavigationBarHidden
        self.buttonLayout = buttonLayout
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureButtons()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(self.isNavigationBarHidden, animated: animated)
    }
}
// MARK: - View Config
extension ImageTitleButtonViewController {
    private func configureViews() {
        illustationImageView.contentMode = .scaleAspectFit
        view.addSubview(illustationImageView)
        view.addSubview(headerContainer)
        view.addSubview(topButton)
        view.addSubview(bottomButton)
    }
    private func configureButtons() {
        switch buttonLayout {
        case .noButton:
            bottomButton.isHidden = true
            topButton.isHidden = true
        case .singleButton:
            bottomButton.isHidden = false
            topButton.isHidden = true
        case .twoButtons:
            bottomButton.isHidden = false
            topButton.isHidden = false
        }
    }
    private func configureConstraints() {
        illustationImageView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.enormous)
            make.size.equalTo(Constants.imageSize.cover)
        }
        headerContainer.snp.remakeConstraints { make in
            make.top.equalTo(illustationImageView.snp.bottom).offset(Constants.spacing.enormous)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        topButton.snp.remakeConstraints { make in
            make.bottom.equalTo(bottomButton.snp.top).offset(-Constants.spacing.small)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        bottomButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
}
