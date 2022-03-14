//
//  ChipView.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 13/1/21.
//

import UIKit

class ChipView: UIView {
    
    private let textLabel = UILabel()
    private let iconImageView = UIImageView()
    private let stackView = UIStackView()
    
    let type: ChipViewType
    
    enum ChipViewType {
        case textOnly
        case icon
    }
    
    var icon: UIImage? {
        get { return iconImageView.image }
        set { iconImageView.image = newValue }
    }
    
    var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    init(frame: CGRect, type: ChipViewType) {
        self.type = type
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension ChipView {
    private func configureViews() {
        
        textLabel.textColor = UIColor.basic.light
        textLabel.font = UIFont.desc
        
        switch type {
        case .icon:
            iconImageView.tintColor = UIColor.basic.light
            stackView.addArrangedSubview(iconImageView)
            stackView.addArrangedSubview(textLabel)
            stackView.axis = .horizontal
            stackView.spacing = Constants.chipView.iconPadding
            addSubview(stackView)
        case .textOnly:
            addSubview(textLabel)
        }
        backgroundColor = UIColor.brand.primary
        layer.cornerRadius = Constants.chipView.cornerRadius
    }
    private func configureConstraints() {
        switch type {
        case .icon:
            stackView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(Constants.spacing.medium)
                make.top.bottom.equalToSuperview().inset(Constants.spacing.small)
            }
        case .textOnly:
            textLabel.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(Constants.spacing.medium)
                make.top.bottom.equalToSuperview().inset(Constants.spacing.small)
            }
        }
    }
}
