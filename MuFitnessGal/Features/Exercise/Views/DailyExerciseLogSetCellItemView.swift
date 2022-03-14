//
//  DailyExerciseLogSetCellItemView.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import UIKit

class DailyExerciseLogSetCellItemView: UIView {
    private let stackView = UIStackView()
    private let labelLabel = UILabel()
    private let valueLabel = UILabel()
    
    var label: String? {
        didSet {
            labelLabel.text = label
        }
    }
    var value: String? {
        didSet {
            valueLabel.text = value
        }
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
extension DailyExerciseLogSetCellItemView {
    private func configureViews() {
        labelLabel.textColor = UIColor.secondaryLabel
        labelLabel.font = UIFont.desc
        stackView.addArrangedSubview(labelLabel)
        
        valueLabel.textColor = UIColor.label
        valueLabel.font = UIFont.bodyBold
        stackView.addArrangedSubview(valueLabel)
        
        stackView.alignment = .leading
        stackView.spacing = Constants.spacing.slight
        stackView.axis = .vertical
        addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
}

