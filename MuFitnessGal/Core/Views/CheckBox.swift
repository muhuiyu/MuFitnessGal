//
//  CheckBox.swift
//  Intellect prototype
//
//  Created by Mu Yu on 23/2/21.
//

import UIKit

protocol CheckBoxDelegate: AnyObject {
    func checkBoxDidChangeState(_ checkBox: CheckBox, changeStateTo isChecked: Bool)
}

class CheckBox: UIView {
    var checkImageView = UIImageView()
    var isChecked: Bool = false {
        didSet {
            reconfigureViews()
        }
    }
    weak var delegate: CheckBoxDelegate?
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
extension CheckBox {
    @objc
    private func didTapInView(_ sender: UITapGestureRecognizer) {
        isChecked = !isChecked
        delegate?.checkBoxDidChangeState(self, changeStateTo: isChecked)
    }
}
// MARK: - View Config
extension CheckBox {
    private func reconfigureViews() {
        if isChecked {
            checkImageView.isHidden = false
        }
        else {
            checkImageView.isHidden = true
        }
    }

    private func configureViews() {
        checkImageView.image = UIImage(systemName: "checkmark")
        checkImageView.tintColor = UIColor.basic.dark
        checkImageView.isHidden = true
        addSubview(checkImageView)
        layer.cornerRadius = 4
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.basic.darkAccent.cgColor
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    private func configureConstraints() {
        checkImageView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.small)
            make.edges.equalToSuperview()
        }
    }
}
