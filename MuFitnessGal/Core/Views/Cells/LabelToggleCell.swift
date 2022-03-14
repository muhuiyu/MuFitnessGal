//
//  LabelToggleCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 16/1/21.
//

import UIKit

class LabelToggleCell: UITableViewCell {
    
    static let reuseID = "LabelToggleCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    
    private let labelLabel = UILabel()
    private let disclourseIconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        
//        AccessoryType.disclosureIndicator
//        UICellAccessory.DisclosureIndicatorOptions
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension LabelToggleCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.basic.dark
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        disclourseIconView.image = UIImage(systemName: "chevron.forward")
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        labelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        disclourseIconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.medium)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelLabel)
        }
    }
}
