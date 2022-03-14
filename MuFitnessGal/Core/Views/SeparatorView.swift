//
//  SeparatorView.swift
//  Lango
//
//  Created by Mu Yu on 23/1/21.
//

import UIKit

class SeparatorView: UIView {
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
extension SeparatorView {
    private func configureViews() {
        backgroundColor = UIColor.basic.accent
    }
    private func configureConstraints() {
        snp.remakeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
}
