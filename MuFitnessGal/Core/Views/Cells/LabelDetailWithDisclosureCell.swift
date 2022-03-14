//
//  LabelDetailWithDisclosureCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 16/1/21.
//

import UIKit

class LabelDetailWithDisclousureCell: UITableViewCell {
    
    static let reuseID = "LabelDetailWithDisclousureCell"
    
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
    private let disclourseIconView = UIImageView()
    
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
extension LabelDetailWithDisclousureCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.basic.dark
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        valueLabel.textColor = UIColor.text.subtle
        valueLabel.font = UIFont.body
        valueLabel.textAlignment = .right
        contentView.addSubview(valueLabel)
        disclourseIconView.image = UIImage(systemName: "chevron.forward")
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        labelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.snp.remakeConstraints { make in
            make.leading.equalTo(labelLabel.snp.trailing).offset(Constants.spacing.medium)
            make.trailing.equalTo(disclourseIconView.snp.leading)
            make.centerY.equalTo(labelLabel)
        }
        disclourseIconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.medium)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelLabel)
        }
    }
}
