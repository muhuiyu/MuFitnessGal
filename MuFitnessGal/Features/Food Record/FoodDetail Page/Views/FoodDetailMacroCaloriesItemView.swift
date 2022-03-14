//
//  FoodDetailMacroCaloriesItemView.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import UIKit

class FoodDetailMacroCaloriesItemView: UIView {
    private let numberLabel = UILabel()
    private let itemLabel = UILabel()
    
    var viewModel: FoodDetailMacroCaloriesItemViewModel? {
        didSet {
            numberLabel.text = viewModel?.numberLabelText
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
extension FoodDetailMacroCaloriesItemView {
    private func configureViews() {
        numberLabel.font = UIFont.bodyBold
        numberLabel.textColor = UIColor.label
        numberLabel.textAlignment = .center
        addSubview(numberLabel)
        
        itemLabel.text = "Kcal"
        itemLabel.font = UIFont.small
        itemLabel.textColor = UIColor.label
        itemLabel.textAlignment = .center
        addSubview(itemLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        numberLabel.snp.remakeConstraints { make in
            make.top.equalTo(layoutMarginsGuide)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(layoutMarginsGuide)
        }
        itemLabel.snp.remakeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(Constants.spacing.slight)
            make.leading.trailing.centerX.equalTo(numberLabel)
            make.bottom.equalTo(layoutMarginsGuide)
        }
    }
}

