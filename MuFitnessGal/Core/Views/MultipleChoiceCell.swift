//
//  MultipleChoiceCell.swift
//  Intellect prototype
//
//  Created by Mu Yu on 18/2/21.
//

import UIKit

class MultipleChoiceCell: UITableViewCell {
    static let reuseID = "MultipleChoiceCell"
    private let containerView = UIView()
    private let label = UILabel()
    
    var labelText: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    var isCellSelected: Bool = false {
        didSet {
            reconfigureColors()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        reconfigureColors()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension MultipleChoiceCell {
    func reconfigureColors() {
        label.numberOfLines = 0
        if isCellSelected {
            containerView.backgroundColor = UIColor.brand.primary
            label.textColor = UIColor.basic.light
        }
        else {
            containerView.backgroundColor = UIColor.brand.light
            label.textColor = UIColor.basic.dark
        }
    }
    private func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        containerView.layer.cornerRadius = 20
        contentView.addSubview(containerView)
        label.font = UIFont.buttonText
        label.textAlignment =  .center
        contentView.addSubview(label)
    }
    private func configureConstraints() {
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.spacing.small)
        }
    }
}
