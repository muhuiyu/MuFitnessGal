//
//  FoodRecordMealHeaderCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordMealHeaderCell: UITableViewCell {
    static let reuseID = "FoodRecordMealHeaderCell"
    
    private let mealNameLabel = UILabel()
    private let macroLabel = UILabel()
    private let caloriesLabel = UILabel()
    
    var viewModel: FoodRecordMealHeaderCellViewModel? {
        didSet {
            macroLabel.text = viewModel?.macroLabelText
            mealNameLabel.text = viewModel?.mealName
            caloriesLabel.text = viewModel?.caloriesLabelText
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
extension FoodRecordMealHeaderCell {
    private func configureViews() {
        mealNameLabel.textColor = UIColor.label
        mealNameLabel.font = UIFont.h3
        contentView.addSubview(mealNameLabel)
        
        macroLabel.textColor = UIColor.systemBlue
        macroLabel.font = UIFont.desc
        contentView.addSubview(macroLabel)
        
        caloriesLabel.textColor = UIColor.label
        caloriesLabel.textAlignment = .right
        caloriesLabel.font = UIFont.h3
        contentView.addSubview(caloriesLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        mealNameLabel.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
            make.leading.equalTo(contentView.layoutMarginsGuide)
        }
        caloriesLabel.snp.remakeConstraints { make in
            make.top.equalTo(mealNameLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(mealNameLabel.snp.trailing)
        }
        macroLabel.snp.remakeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(Constants.spacing.trivial)
            make.leading.equalTo(mealNameLabel)
            make.trailing.equalTo(caloriesLabel)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}
