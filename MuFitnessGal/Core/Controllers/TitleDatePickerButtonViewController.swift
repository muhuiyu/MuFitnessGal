//
//  TitleDatePickerButtonViewController.swift
//  Intellect prototype
//
//  Created by Mu Yu on 23/2/21.
//

import UIKit

class TitleDatePickerButtonViewController: ViewController {
    
    private let headerContainer = HeaderWithLargeTitleView()
    private let datePicker = UIDatePicker()
    private let nextButton = TextButton(buttonType: .primary)
    
    var headerText: String? {
        get { return headerContainer.header }
        set { headerContainer.header = newValue }
    }
    var titleText: String? {
        get { return headerContainer.text }
        set { headerContainer.text = newValue }
    }
    var subtitleText: String? {
        get { return headerContainer.subtitle }
        set { headerContainer.subtitle = newValue }
    }
    var date: Date {
        get { return datePicker.date }
        set { datePicker.date = newValue }
    }
    var isButtonHidden: Bool = false {
        didSet {
            nextButton.isHidden = isButtonHidden
        }
    }
    var buttonType: TextButton.ButtonType? {
        get { return nextButton.buttonType }
        set { nextButton.buttonType = newValue ?? .primary }
    }
    var buttonText: String? {
        get { return nextButton.text }
        set { nextButton.text = newValue }
    }
    var tapHandler: (() -> Void)? {
        didSet {
            nextButton.tapHandler = tapHandler
        }
    }
    let isNavigationBarHidden: Bool
    init(isNavigationBarHidden: Bool = false) {
        self.isNavigationBarHidden = isNavigationBarHidden
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(self.isNavigationBarHidden, animated: animated)
    }
}
// MARK: - View Config
extension TitleDatePickerButtonViewController {
    private func configureViews() {
        view.addSubview(headerContainer)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        view.addSubview(datePicker)
        nextButton.isEnable = true
        view.addSubview(nextButton)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        headerContainer.snp.remakeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        datePicker.snp.remakeConstraints { make in
            make.top.equalTo(headerContainer.snp.bottom).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        nextButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
}
