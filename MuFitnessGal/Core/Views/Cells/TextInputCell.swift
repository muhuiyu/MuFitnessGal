//
//  TextInputCell.swift
//  Mu-do list
//
//  Created by Mu Yu on 16/10/20.
//

import UIKit

class TextInputCell: UITableViewCell {
    static let reuseID = "TextInputCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var value: String? {
        get { return valueTextField.text }
        set { valueTextField.text = newValue }
    }
    var placeholder: String? {
        get { return valueTextField.placeholder }
        set { valueTextField.placeholder = newValue }
    }
    var inputKeyboardType: UIKeyboardType? {
        didSet {
            guard let inputKeyboardType = inputKeyboardType else { return }
            valueTextField.keyboardType = inputKeyboardType
        }
    }
    
    private let labelLabel = UILabel()
    private let valueTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(
            width: superSize.width,
            height: max(superSize.height, 44)
        )
    }
    
    @discardableResult              // can be called without caring about the return value
    override func becomeFirstResponder() -> Bool {      // auto focus
        return valueTextField.becomeFirstResponder()
    }
    
}

// MARK: - View Config
extension TextInputCell {
    private func configureViews() {
        selectionStyle = .none
        
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        
        valueTextField.textAlignment = .right
        contentView.addSubview(valueTextField)
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        labelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        valueTextField.snp.remakeConstraints { make in
            make.leading.equalTo(labelLabel.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelLabel)
        }
    }
}
