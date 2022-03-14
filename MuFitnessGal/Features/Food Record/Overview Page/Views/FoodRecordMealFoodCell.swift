//
//  FoodRecordMealFoodCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordMealFoodCell: UITableViewCell {
    static let reuseID = "FoodRecordMealFoodCell"
    
    private let stackView = UIStackView()
    private let nameLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let caloriesLabel = UILabel()

    var viewModel: FoodRecordMealFoodCellViewModel? {
        didSet {
            nameLabel.text = viewModel?.foodName
            subtitleLabel.text = viewModel?.subtitleLabelText
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
extension FoodRecordMealFoodCell {
    private func configureViews() {
        nameLabel.font = UIFont.body
        nameLabel.textColor = UIColor.label
        stackView.addArrangedSubview(nameLabel)
        
        subtitleLabel.font = UIFont.small
        subtitleLabel.textColor = UIColor.secondaryLabel
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing.trivial
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        
        caloriesLabel.textAlignment = .right
        caloriesLabel.font = UIFont.body
        caloriesLabel.textColor = UIColor.label
        contentView.addSubview(caloriesLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        caloriesLabel.snp.remakeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(Constants.spacing.small)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.top.bottom.lessThanOrEqualToSuperview()
        }
    }
}
