//
//  FoodRecordNutrientSummaryCell.swift
//  Foodie
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordDailyMacroCell: UITableViewCell {
    static let reuseID = "FoodRecordDailyMacroCell"
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let caloriesItem = FoodRecordDailyMacroItemView()
    private let carbsItem = FoodRecordDailyMacroItemView()
    private let proteinItem = FoodRecordDailyMacroItemView()
    private let fatItem = FoodRecordDailyMacroItemView()
    
    var viewModel: FoodRecordDailyMacroCellViewModel? {
        didSet {
            caloriesItem.viewModel = viewModel?.viewModel(of: .calories)
            carbsItem.viewModel = viewModel?.viewModel(of: .carbs)
            proteinItem.viewModel = viewModel?.viewModel(of: .protein)
            fatItem.viewModel = viewModel?.viewModel(of: .fat)
        }
    }
    
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
// MARK: - View Config
extension FoodRecordDailyMacroCell {
    private func configureViews() {
        contentView.backgroundColor = .white
        
        titleLabel.font = UIFont.h3
        titleLabel.textColor = UIColor.label
        titleLabel.text = "Nutrients remaining"
        contentView.addSubview(titleLabel)
        
        stackView.addArrangedSubview(caloriesItem)
        stackView.addArrangedSubview(carbsItem)
        stackView.addArrangedSubview(proteinItem)
        stackView.addArrangedSubview(fatItem)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing.medium)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}
