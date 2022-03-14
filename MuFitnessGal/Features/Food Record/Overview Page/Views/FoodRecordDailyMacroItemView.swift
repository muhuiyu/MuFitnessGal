//
//  FoodRecordSummaryNutrientItem.swift
//  Foodie
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordDailyMacroItemView: UIView {
    
    private let numberStack = UIStackView()
    private let consumedLabel = UILabel()
    private let goalLabel = UILabel()
    private let nameLabel = UILabel()
    
    var viewModel: FoodRecordDailyMacroItemViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            consumedLabel.text = viewModel?.consumedString
            goalLabel.text = viewModel?.goalString
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
extension FoodRecordDailyMacroItemView {
    private func configureViews() {
        consumedLabel.font = UIFont.descBold
        consumedLabel.textColor = UIColor.label
        numberStack.addArrangedSubview(consumedLabel)
        
        goalLabel.font = UIFont.desc
        goalLabel.textColor = UIColor.label
        numberStack.addArrangedSubview(goalLabel)
        
        numberStack.axis = .horizontal
        numberStack.spacing = Constants.spacing.slight
        numberStack.alignment = .center
        addSubview(numberStack)
        
        nameLabel.font = UIFont.descBold
        nameLabel.textColor = UIColor.label
        addSubview(nameLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        numberStack.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.lessThanOrEqualToSuperview()
        }
        nameLabel.snp.remakeConstraints { make in
            make.top.equalTo(numberStack.snp.bottom).offset(Constants.spacing.trivial)
            make.leading.trailing.equalTo(numberStack)
            make.bottom.equalToSuperview()
        }
    }
}

