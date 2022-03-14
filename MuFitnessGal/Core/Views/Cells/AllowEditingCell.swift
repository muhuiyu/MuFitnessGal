//
//  AllowEditingCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 13/1/21.
//

import UIKit

protocol AllowEditingCellDelgate: AnyObject {
    func requestDeleteCell(_ cell: AllowEditingCell)
    func requestAddNewCell(_ cell: AllowEditingCell)
}

class AllowEditingCell: UITableViewCell {
    
    static let reuseID = "allowEditingCell"
    
    private var accessoryButton = RoundButton(icon: UIImage(systemName: "plus")!, buttonColor: UIColor.action.success, iconColor: UIColor.white)
    
    private let labelStackView = UIStackView()
    private let labelLabel = UILabel()
    private let labelDisclosureIcon = UIImageView()
    
    var labelStackWidth: CGFloat = 0 {
        didSet {
            
        }
    }
    
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
    
    var indexPath: IndexPath?
    
    var type: AllowEditingCellType? {
        didSet {
            switch type {
            case .add:
                guard let icon = UIImage(systemName: "plus") else { return }
                accessoryButton.icon = icon
                accessoryButton.buttonColor = UIColor.action.success
            case .remove:
                guard let icon = UIImage(systemName: "minus") else { return }
                accessoryButton.icon = icon
                accessoryButton.buttonColor = UIColor.action.destructive
            case .removeWithValue:
                guard let icon = UIImage(systemName: "minus") else { return }
                accessoryButton.icon = icon
                accessoryButton.buttonColor = UIColor.action.destructive
            default: break
            }
            reconfigureViews()
            reconfigureConstraints()
        }
    }
    
    enum AllowEditingCellType {
        case remove
        case add
        case removeWithValue
    }
    
    weak var delegate: AllowEditingCellDelgate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension AllowEditingCell {
    @objc
    private func didTapAccessoryButton() {
        switch type {
        case .remove:
            delegate?.requestDeleteCell(self)
        case .removeWithValue:
            delegate?.requestDeleteCell(self)
        default:
            return
        }
    }
    @objc
    private func didTapEntireCell() {
        if type == .add {
            delegate?.requestAddNewCell(self)
        }
        return
    }
}

// MARK: - View Config
extension AllowEditingCell {
    private func configureViews() {
        contentView.addSubview(accessoryButton)
        
        labelLabel.font = UIFont.body
        labelStackView.addArrangedSubview(labelLabel)
        labelStackView.axis = .horizontal
        labelStackView.spacing = Constants.spacing.small
        contentView.addSubview(labelStackView)
    }
    private func reconfigureViews() {
        switch type {
        case .removeWithValue:
            labelDisclosureIcon.image = UIImage(systemName: "chevron.forward")
            labelStackView.addArrangedSubview(labelDisclosureIcon)
            
            verticalSeparatorView.backgroundColor = UIColor.basic.darkAccent
            contentView.addSubview(verticalSeparatorView)
            valueTextField.font = UIFont.body
            valueTextField.textAlignment = .right
            contentView.addSubview(valueTextField)
        default: break
        }
    }
    private func reconfigureLabelStackWidth() {
        labelStackView.snp.remakeConstraints { make in
            make.width.equalTo(labelStackWidth)
        }
    }
    private func configureGestures() {
        let tapEntireCellGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEntireCell))
        let tapAccessoryButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAccessoryButton))
        contentView.addGestureRecognizer(tapEntireCellGestureRecognizer)
        accessoryButton.addGestureRecognizer(tapAccessoryButtonGestureRecognizer)
    }
    private func reconfigureConstraints() {
        accessoryButton.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.iconButtonSize.trivial)
        }
        switch type {
        case .removeWithValue:
            labelStackView.snp.remakeConstraints { make in
                make.leading.equalTo(accessoryButton.snp.trailing).offset(Constants.spacing.small)
                make.centerY.equalTo(accessoryButton)
                make.width.lessThanOrEqualToSuperview().multipliedBy(0.3)
            }
            verticalSeparatorView.snp.remakeConstraints { make in
                make.leading.equalTo(labelStackView.snp.trailing).offset(Constants.spacing.small)
                make.width.equalTo(0.5)
                make.height.equalTo(40)
                make.centerY.equalTo(accessoryButton)
            }
            valueTextField.snp.remakeConstraints { make in
                make.leading.equalTo(verticalSeparatorView.snp.trailing).offset(Constants.spacing.medium)
                make.trailing.equalTo(contentView.layoutMarginsGuide)
                make.centerY.equalTo(accessoryButton)
            }
        default:
            labelStackView.snp.remakeConstraints { make in
                make.leading.equalTo(accessoryButton.snp.trailing).offset(Constants.spacing.small)
                make.trailing.equalTo(contentView.layoutMarginsGuide)
                make.centerY.equalTo(accessoryButton)
            }
        }
        labelDisclosureIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelDisclosureIcon.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
