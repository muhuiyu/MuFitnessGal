//
//  FoodDetailMacroCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/6/22.
//

import UIKit

class FoodDetailMacroCell: UITableViewCell {
    static let reuseID = "FoodDetailMacroCell"
    
    private let stackView = UIStackView()
    private let calroiesItemView = FoodDetailMacroCaloriesItemView()
    private let carbsItemView = FoodDetailMacroItemView()
    private let proteinItemView = FoodDetailMacroItemView()
    private let fatItemView = FoodDetailMacroItemView()
    
    var viewModel: FoodDetailMacroCellViewModel? {
        didSet {
            calroiesItemView.viewModel = viewModel?.viewModelOfCalories()
            carbsItemView.viewModel = viewModel?.viewModel(of: .carbs)
            proteinItemView.viewModel = viewModel?.viewModel(of: .protein)
            fatItemView.viewModel = viewModel?.viewModel(of: .fat)
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
extension FoodDetailMacroCell {
    private func configureViews() {
        stackView.addArrangedSubview(calroiesItemView)
        stackView.addArrangedSubview(carbsItemView)
        stackView.addArrangedSubview(proteinItemView)
        stackView.addArrangedSubview(fatItemView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}
