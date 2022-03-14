//
//  LabelActionsheetSelectorCell.swift
//  Muney
//
//  Created by Mu Yu on 7/8/21.
//

import UIKit

protocol LabelActionsheetSelectorCellDelegate: AnyObject {
    func labelActionsheetSelectorCell(_ cell: LabelActionsheetSelectorCell, didRequestPresentActionsheetWithItems items: [String], forLabelAs label: String)
//    func labelActionsheetSelectorCell(_ cell: LabelActionsheetSelectorCell, didSelectIndexAs index: Int)
//    func labelActionsheetSelectorCellDidRequestDismiss(_ cell: LabelActionsheetSelectorCell)
}

class LabelActionsheetSelectorCell: UITableViewCell {
    static let reuseID = "LabelDetailCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var value: String? {
        get { return valueLabel.text }
        set { valueLabel.text = newValue }
    }
    var items: [String] = []
    
    private let labelLabel = UILabel()
    private let valueLabel = UILabel()
    private let interactiveView = UIView()
    
    weak var delegate: LabelActionsheetSelectorCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension LabelActionsheetSelectorCell {
    @objc
    private func didTapInteractiveView() {
        delegate?.labelActionsheetSelectorCell(self, didRequestPresentActionsheetWithItems: self.items, forLabelAs: self.label ?? "")
    }
}
// MARK: - View Config
extension LabelActionsheetSelectorCell {
    private func configureViews() {
        selectionStyle = .none
        
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        valueLabel.textColor = UIColor.secondaryLabel
        valueLabel.font = UIFont.body
        valueLabel.textAlignment = .right
        contentView.addSubview(valueLabel)
        contentView.addSubview(interactiveView)
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInteractiveView))
        interactiveView.addGestureRecognizer(tapRecognizer)
    }

    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        labelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        valueLabel.snp.remakeConstraints { make in
            make.leading.equalTo(labelLabel.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(labelLabel)
        }
        interactiveView.snp.remakeConstraints { make in
            make.leading.equalTo(labelLabel.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
