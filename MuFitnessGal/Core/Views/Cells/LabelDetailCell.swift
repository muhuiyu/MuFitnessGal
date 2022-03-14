//
//  LabelDetailCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 16/1/21.
//

import UIKit

class LabelDetailCell: UITableViewCell {
    static let reuseID = "LabelDetailCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var value: String? {
        get { return valueLabel.text }
        set { valueLabel.text = newValue }
    }
    
    private let labelLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension LabelDetailCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        valueLabel.textColor = UIColor.secondaryLabel
        valueLabel.font = UIFont.body
        valueLabel.textAlignment = .right
        contentView.addSubview(valueLabel)
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        labelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        valueLabel.snp.remakeConstraints { make in
            make.leading.equalTo(labelLabel.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelLabel)
        }
    }
}
