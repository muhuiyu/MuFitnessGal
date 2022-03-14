//
//  CardImageTitleSubtitleButton.swift
//  Intellect Prototype
//
//  Created by Mu Yu on 22/1/21.
//

import UIKit

class CardImageTitleSubtitleButton: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = TextButton(buttonType: .primary)
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    var buttonText: String? {
        get { return actionButton.text }
        set { actionButton.text = newValue }
    }
    var tapHandler: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension CardImageTitleSubtitleButton {
    @objc
    private func didTapCard() {
        tapHandler?()
    }
}
// MARK: - View Config
extension CardImageTitleSubtitleButton {
    private func configureViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.h3
        addSubview(titleLabel)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.label
        subtitleLabel.font = UIFont.small
        addSubview(subtitleLabel)
        addSubview(actionButton)
        layer.cornerRadius = Constants.card.cornerRadius
    }
    private func configureGestures() {
        let tapRecoginier = UITapGestureRecognizer(target: self, action: #selector(didTapCard))
        addGestureRecognizer(tapRecoginier)
    }
    private func configureConstraints() {
        imageView.snp.remakeConstraints { make in
            make.top.equalTo(layoutMarginsGuide).inset(Constants.spacing.medium)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.imageSize.illustation)
        }
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.spacing.medium)
            make.centerX.equalToSuperview()
        }
        subtitleLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing.medium)
            make.centerX.equalToSuperview()
        }
        actionButton.snp.remakeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.spacing.medium)
            make.height.equalTo(36)
            make.leading.trailing.bottom.equalTo(layoutMarginsGuide).inset(Constants.spacing.medium)
        }
    }
}


