//
//  CardTitleImageButton.swift
//  Intellect Prototype
//
//  Created by Mu Yu on 22/1/21.
//

import UIKit

class CardTitleImageButton: UIView {
    
    private let headerContainer = UIView()
    private let textStackView = UIStackView()
    private let headerLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    private let actionButton = TextButton(buttonType: .primary)
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    var headerText: String? {
        get { return headerLabel.text }
        set { headerLabel.text = newValue }
    }
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
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
extension CardTitleImageButton {
    @objc
    private func didTapCard() {
        tapHandler?()
    }
}
// MARK: - View Config
extension CardTitleImageButton {
    private func configureViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        headerContainer.addSubview(imageView)
        addSubview(headerContainer)
        
        headerLabel.textColor = UIColor.text.subtle
        headerLabel.font = UIFont.small
        titleLabel.textColor = UIColor.basic.dark
        titleLabel.font = UIFont.h3
        titleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.basic.dark
        subtitleLabel.font = UIFont.small
        textStackView.addArrangedSubview(headerLabel)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        textStackView.axis = .vertical
        textStackView.spacing = Constants.spacing.small
        textStackView.alignment = .leading
        
        addSubview(textStackView)
        
        addSubview(actionButton)
        layer.cornerRadius = Constants.card.cornerRadius
    }
    private func configureGestures() {
        let tapRecoginier = UITapGestureRecognizer(target: self, action: #selector(didTapCard))
        addGestureRecognizer(tapRecoginier)
    }
    private func configureConstraints() {
        imageView.snp.remakeConstraints { make in
            make.trailing.bottom.equalTo(headerContainer.layoutMarginsGuide).inset(Constants.spacing.small)
            make.size.equalTo(Constants.imageSize.thumbnail)
        }
        headerContainer.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.leading.trailing.equalTo(layoutMarginsGuide).inset(Constants.spacing.medium)
        }
        textStackView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(layoutMarginsGuide).inset(Constants.spacing.small)
        }
        actionButton.snp.remakeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(Constants.spacing.medium)
            make.leading.equalTo(textStackView)
            make.width.equalTo(200)
            make.bottom.equalTo(layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}

