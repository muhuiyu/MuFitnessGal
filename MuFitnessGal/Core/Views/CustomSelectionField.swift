//
//  CustomSelectionField.swift
//  Lango
//
//  Created by Mu Yu on 30/1/21.
//

import UIKit

class CustomSelectionField: UIView {
    private let textLabel = UILabel()
    private let disclosureIconView = UIImageView()
    
    var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    var isEmpty: Bool = true {
        didSet {
            reconfigureViews()
        }
    }
    var tapHandler: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        reconfigureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Actions
extension CustomSelectionField {
    @objc
    private func didTapView(_ sender: UITapGestureRecognizer) {
        self.tapHandler?()
    }
}
// MARK: - View Config
extension CustomSelectionField {
    private func reconfigureViews() {
        if self.isEmpty {
            textLabel.textColor = UIColor.text.subtle
            disclosureIconView.tintColor = UIColor.text.subtle
        }
        else {
            textLabel.textColor = UIColor.basic.dark
            disclosureIconView.tintColor = UIColor.basic.dark
        }
    }
    private func configureViews() {
        textLabel.textColor = UIColor.basic.dark
        textLabel.font = UIFont.body
        addSubview(textLabel)
        
        disclosureIconView.contentMode = .scaleAspectFit
        disclosureIconView.image = UIImage(systemName: "chevron.forward")
        addSubview(disclosureIconView)
        
        backgroundColor = UIColor.basic.accent
        layer.cornerRadius = Constants.textField.cornerRaduis
    }
    private func configureGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    private func configureConstraints() {
        textLabel.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(Constants.spacing.medium)
        }
        disclosureIconView.snp.remakeConstraints { make in
            make.leading.equalTo(textLabel.snp.trailing).offset(Constants.spacing.small)
            make.trailing.equalToSuperview().inset(Constants.spacing.medium)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.iconButtonSize.small)
        }
    }
}
