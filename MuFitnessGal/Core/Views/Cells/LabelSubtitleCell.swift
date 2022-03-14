//
//  LabelSubtitleCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import UIKit

class LabelSubtitleCell: UITableViewCell {
    static let reuseID = "LabelSubtitleCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    private let stackView = UIStackView()
    private let labelLabel = UILabel()
    private let subtitleLabel = UILabel()
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
extension LabelSubtitleCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.bodyBold
        stackView.addArrangedSubview(labelLabel)
        
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.font = UIFont.small
        subtitleLabel.textAlignment = .right
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing.slight
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        
        disclourseIconView.image = UIImage(systemName: "ellipsis")
        disclourseIconView.sizeToFit()
        contentView.addSubview(disclourseIconView)
    }
    
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.trailing.equalTo(disclourseIconView.snp.leading).offset(-Constants.spacing.small)
        }
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        disclourseIconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.trivial)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }
}
