//
//  SetTimerView.swift
//  Intellect prototype
//
//  Created by Mu Yu on 23/2/21.
//

import UIKit

class SetTimerView: UIView {
    private let textlabel = UILabel()
    private let timePicker = UIDatePicker()
    
    var text: String? {
        get { return textlabel.text }
        set { textlabel.text = newValue }
    }
    
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
// MARK: - View Config
extension SetTimerView {
    private func configureViews() {
        textlabel.textColor = UIColor.basic.dark
        textlabel.font = UIFont.bodyBold
        addSubview(textlabel)
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .compact
        addSubview(timePicker)
        
        layer.cornerRadius = Constants.card.cornerRadius
        backgroundColor = .orange
    }
    private func configureGestures() {
    }
    private func configureConstraints() {
        textlabel.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        timePicker.snp.remakeConstraints { make in
            make.trailing.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }
}
