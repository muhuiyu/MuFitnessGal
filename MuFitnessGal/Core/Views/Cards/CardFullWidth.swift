//
//  CardFullWidth.swift
//  Lango
//
//  Created by Mu Yu on 19/1/21.
//

import UIKit

class CardFullWidth: UIView {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
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
extension CardFullWidth {
    @objc
    private func didTapCard() {
        tapHandler?()
    }
}
// MARK: - View Config
extension CardFullWidth {
    private func configureViews() {
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.bodyHeavy
        stackView.addArrangedSubview(titleLabel)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.label
        subtitleLabel.font = UIFont.small
        stackView.addArrangedSubview(subtitleLabel)
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing.small
        addSubview(stackView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        layer.cornerRadius = Constants.card.cornerRadius
    }
    private func configureGestures() {
        let tapRecoginier = UITapGestureRecognizer(target: self, action: #selector(didTapCard))
        addGestureRecognizer(tapRecoginier)
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.leading.equalTo(layoutMarginsGuide).inset(Constants.spacing.small)
            make.trailing.equalTo(imageView.snp.leading).offset(-Constants.spacing.medium)
        }
        imageView.snp.remakeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.size.equalTo(snp.height).multipliedBy(0.7)
        }
    }
}
