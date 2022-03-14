//
//  LabelCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 16/1/21.
//

import UIKit

class LabelCell: UITableViewCell {
    static let reuseID = "LabelCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    
    private let labelLabel = UILabel()
    
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
extension LabelCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }
}
