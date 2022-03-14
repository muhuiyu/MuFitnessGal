//
//  CustomizedTextField.swift
//  Lango
//
//  Created by Mu Yu on 30/1/21.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func customTextFieldDidFillText(_ view: CustomTextField)
    func customTextFieldDidClearText(_ view: CustomTextField)
    func customTextFieldDidTapIcon(_ view: CustomTextField)
}

class CustomTextField: UIView {
    private let textField = UITextField()
    private let iconImageView = UIImageView()
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    var icon: UIImage? {
        get { return iconImageView.image }
        set { iconImageView.image = newValue }
    }
    var returnKeyType: UIReturnKeyType = .go {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    var placeholderText: String = "" {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.text.subtle, NSAttributedString.Key.font: UIFont.body as Any])
        }
    }
    var cornerRadius: CGFloat = Constants.textField.cornerRaduis {
        didSet {
            textField.layer.cornerRadius = cornerRadius
        }
    }
    var isSecureText: Bool {
        get { return textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }

    weak var delegate: CustomTextFieldDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Actions
extension CustomTextField {
    @objc
    private func textFieldValueDidChange(_ sender: UITextField) {
        if sender.text == "" {
            delegate?.customTextFieldDidClearText(self)
        }
        else {
            delegate?.customTextFieldDidFillText(self)
        }
    }
    @objc
    private func didTapIcon() {
        delegate?.customTextFieldDidTapIcon(self)
    }
    @objc
    private func didTapTextField() {
        print("tap tap tap")
    }
}
// MARK: - View Config
extension CustomTextField {
    private func configureViews() {
        
        textField.textColor = UIColor.basic.dark
        textField.font = UIFont.body
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(didTapTextField), for: .allTouchEvents)
        textField.addTarget(self, action: #selector(textFieldValueDidChange), for: .allEditingEvents)
        addSubview(textField)
        
        iconImageView.tintColor = UIColor.basic.darkAccent
        iconImageView.isUserInteractionEnabled = true
        addSubview(iconImageView)
        
        backgroundColor = UIColor.basic.accent
        layer.cornerRadius = Constants.textField.cornerRaduis
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapIcon))
        iconImageView.addGestureRecognizer(tapRecognizer)
    }
    private func configureConstraints() {
        iconImageView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.small)
            make.trailing.equalTo(textField).inset(Constants.spacing.small)
            make.centerY.equalToSuperview()
        }
        textField.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.spacing.medium)
        }
    }
}
