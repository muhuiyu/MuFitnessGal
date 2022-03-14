//
//  EmptyView.swift
//  Lango
//
//  Created by Mu Yu on 18/1/21.
//

import UIKit

class EmptyView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var descriptionText: String? {
        get { return descriptionLabel.text }
        set { descriptionLabel.text = newValue }
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
extension EmptyView {
    private func configureViews() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        titleLabel.textColor = UIColor.basic.dark
        titleLabel.font = UIFont.body
        addSubview(titleLabel)
        descriptionLabel.textColor = UIColor.text.subtle
        descriptionLabel.font = UIFont.small
        addSubview(descriptionLabel)
    }
    private func configureConstraints() {
        imageView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(snp.width)
            make.top.equalToSuperview()
        }
        titleLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(Constants.spacing.large)
        }
        descriptionLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing.medium)
            make.bottom.equalToSuperview()
        }
    }
}
