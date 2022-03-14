//
//  BullettItemTitleSubtitleView.swift
//  Intellect prototype
//
//  Created by Mu Yu on 21/2/21.
//

import UIKit

class BullettItemTitleSubtitleView: UIView {
    
    private let icon = UIImageView()
    private let textStack = UIStackView()
    private let title = UILabel()
    private let subtitle = UILabel()
    
    var themeColor: UIColor? {
        didSet {
            icon.tintColor = themeColor
            title.textColor = themeColor
            subtitle.textColor = themeColor
        }
    }
    var bulletIcon: UIImage? {
        get { return icon.image }
        set { icon.image = newValue }
    }
    var titleText: String? {
        get { return title.text }
        set { title.text = newValue }
    }
    var subtitleText: String? {
        get { return subtitle.text }
        set { subtitle.text = newValue }
    }
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension BullettItemTitleSubtitleView {
    private func configureViews() {
        addSubview(icon)
        title.font = UIFont.smallBold
        textStack.addArrangedSubview(title)
        subtitle.alpha = 0.8
        subtitle.font = UIFont.desc
        textStack.addArrangedSubview(subtitle)
        textStack.spacing = Constants.spacing.trivial
        textStack.axis = .vertical
        textStack.alignment = .leading
        addSubview(textStack)
    }
    private func configureConstraints() {
        icon.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        textStack.snp.remakeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(Constants.spacing.small)
        }
    }
}
