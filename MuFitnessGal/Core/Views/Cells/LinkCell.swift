//
//  LinkCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 14/1/21.
//

import UIKit

class LinkCell: UITableViewCell {
    
    static let reuseID = "linkCell"

    private let labelLabel = UILabel()
    
    var linkText: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var linkColor: UIColor? {
        get { return labelLabel.textColor }
        set { labelLabel.textColor = newValue }
    }
    var indexPath: IndexPath?
     
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
extension LinkCell {
}

// MARK: - View Config
extension LinkCell {
    private func configureViews() {
        labelLabel.font = UIFont.bodyBold
        labelLabel.textColor = UIColor.text.buttonLink
        contentView.addSubview(labelLabel)
    }
    private func configureGestures() {
       
    }
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }
}

