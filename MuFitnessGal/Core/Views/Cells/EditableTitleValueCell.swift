//
//  EditableTitleValueCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 13/1/21.
//

import UIKit

protocol EditableTitleValueCellDelgate: AnyObject {
    func requestChangeLabel(_ cell: EditableTitleValueCell)
    func requestChangeValue(_ cell: EditableTitleValueCell, newValue: String)
}

class EditableTitleValueCell: UITableViewCell {
    
    static let reuseID = "editableTitleValueCell"

    private let labelSelectionStackView = UIStackView()
    private let labelLabel = UILabel()
    private let labelDisclosureIcon = UIImageView()
    private let verticalSeparatorView = UIView()
    private let valueTextField = UITextField()
    
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
    var labelSelectionWidthRatio: CGFloat = 0.4 {
        didSet {
            labelSelectionStackView.snp.remakeConstraints { make in
                make.width.equalToSuperview().multipliedBy(labelSelectionWidthRatio)
            }
        }
    }
    var isLabelEditble: Bool = true {
        didSet {
            reconfigureViews()
            reconfigureConstraints()
        }
    }
    var indexPath: IndexPath?
    weak var delegate: EditableTitleValueCellDelgate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension EditableTitleValueCell {
    @objc
    private func didTapLabelSelection() {
        if isLabelEditble {
            delegate?.requestChangeLabel(self)
        }
    }
    @objc
    private func valueEditingDidChange() {
        guard let text = valueTextField.text else { return }
        self.delegate?.requestChangeValue(self, newValue: text)
    }
}

// MARK: - View Config
extension EditableTitleValueCell {
    private func reconfigureViews() {
        if isLabelEditble {
            labelDisclosureIcon.contentMode = .scaleAspectFit
            labelDisclosureIcon.image = UIImage(systemName: "chevron.forward")
            labelDisclosureIcon.tintColor = UIColor.basic.darkAccent
            labelSelectionStackView.addArrangedSubview(labelDisclosureIcon)
        }
    }
    private func reconfigureConstraints() {
        if isLabelEditble {
            labelDisclosureIcon.snp.remakeConstraints { make in
                make.size.equalTo(Constants.iconButtonSize.trivial)
            }
            labelDisclosureIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            labelDisclosureIcon.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
    }
    private func configureViews() {
        labelLabel.font = UIFont.body
        labelLabel.textColor = UIColor.text.buttonLink
        labelSelectionStackView.addArrangedSubview(labelLabel)
        
        labelSelectionStackView.axis = .horizontal
        labelSelectionStackView.spacing = Constants.spacing.small
        contentView.addSubview(labelSelectionStackView)
        verticalSeparatorView.backgroundColor = UIColor.basic.darkAccent
        contentView.addSubview(verticalSeparatorView)
        
        valueTextField.delegate = self
//        valueTextField.addTarget(self, action: #selector(valueEditingDidChange), for: .editingChanged)
        contentView.addSubview(valueTextField)
    }
    private func configureGestures() {
        let tapLabelSelectionGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLabelSelection))
        contentView.addGestureRecognizer(tapLabelSelectionGestureRecognizer)
    }
    private func configureConstraints() {
        labelSelectionStackView.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        verticalSeparatorView.snp.remakeConstraints { make in
            make.leading.equalTo(labelSelectionStackView.snp.trailing).offset(Constants.spacing.small)
            make.width.equalTo(0.5)
            make.height.equalTo(40)
            make.centerY.equalTo(labelSelectionStackView)
        }
        valueTextField.snp.remakeConstraints { make in
            make.leading.equalTo(verticalSeparatorView.snp.trailing).offset(Constants.spacing.medium)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelSelectionStackView)
        }
    }
}

// MARK: - TextField Delegate
extension EditableTitleValueCell: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        guard let text = textField.text else { return false }
//        self.delegate?.didRequestChangeValue(self, value: text)
//        return true
//    }
}
