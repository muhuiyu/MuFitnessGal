//
//  TextViewCell.swift
//  Mu-do list
//
//  Created by Mu Yu on 16/10/20.
//

import UIKit

class TextViewCell: UITableViewCell {
    static let reuseID = "TextViewCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var value: String? {
        get { return valueTextView.text }
        set { valueTextView.text = newValue }
    }
    
    private let labelLabel = UILabel()
    private let valueTextView = UITextView()
    
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
extension TextViewCell {
    private func configureViews() {
        selectionStyle = .none
        
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        
        valueTextView.textAlignment = .left
        valueTextView.isEditable = true
        valueTextView.font = .systemFont(ofSize: 16, weight: .regular)
        
        contentView.addSubview(valueTextView)
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.top.equalToSuperview().inset(12)
        }
        
        valueTextView.snp.remakeConstraints { make in
            make.top.equalTo(labelLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide).inset(-4)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(80)
        }
    }
}
