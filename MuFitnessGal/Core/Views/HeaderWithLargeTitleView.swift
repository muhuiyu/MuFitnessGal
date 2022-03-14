//
//  HeaderWithLargeTitleView.swift
//  Lango
//
//  Created by Mu Yu on 18/1/21.
//

import UIKit

class HeaderWithLargeTitleView: UIView {
    
    private let stackView = UIStackView()
    private let headerLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    var textColor: UIColor? {
        didSet {
            titleLabel.textColor = textColor
            subtitleLabel.textColor = textColor
            headerLabel.textColor = textColor
        }
    }
    var header: String? {
        get { return headerLabel.text }
        set { headerLabel.text = newValue }
    }
    var text: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension HeaderWithLargeTitleView {
    private func configureViews() {
        headerLabel.font = UIFont.small
        headerLabel.numberOfLines = 0
        headerLabel.textColor = UIColor.text.subtle
        stackView.addArrangedSubview(headerLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.h2
        titleLabel.textColor = UIColor.basic.dark
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.body
        subtitleLabel.textColor = UIColor.text.subtle
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing.small
        addSubview(stackView)
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(layoutMarginsGuide)
        }
    }
}
