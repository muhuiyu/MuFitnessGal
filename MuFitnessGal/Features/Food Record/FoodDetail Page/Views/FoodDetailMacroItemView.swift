//
//  FoodDetailMacroItem.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/6/22.
//

import UIKit

class FoodDetailMacroItemView: UIView {
    
    private let ratioLabel = UILabel()
    private let gramLabel = UILabel()
    private let itemLabel = UILabel()
    
    var viewModel: FoodDetailMacroItemViewModel? {
        didSet {
            ratioLabel.text = viewModel?.ratioLabelText
            gramLabel.text = viewModel?.gramLabelText
            itemLabel.text = viewModel?.itemLabelText
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
extension FoodDetailMacroItemView {
    private func configureViews() {
        ratioLabel.font = UIFont.small
        ratioLabel.textAlignment = .center
        addSubview(ratioLabel)
        
        gramLabel.font = UIFont.bodyBold
        gramLabel.textColor = UIColor.label
        gramLabel.textAlignment = .center
        addSubview(gramLabel)
        
        itemLabel.font = UIFont.small
        itemLabel.textColor = UIColor.label
        itemLabel.textAlignment = .center
        addSubview(itemLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        ratioLabel.snp.remakeConstraints { make in
            make.top.equalTo(layoutMarginsGuide)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(layoutMarginsGuide)
        }
        gramLabel.snp.remakeConstraints { make in
            make.top.equalTo(ratioLabel.snp.bottom).offset(Constants.spacing.slight)
            make.leading.trailing.centerX.equalTo(ratioLabel)
        }
        itemLabel.snp.remakeConstraints { make in
            make.top.equalTo(gramLabel.snp.bottom).offset(Constants.spacing.slight)
            make.leading.trailing.centerX.equalTo(ratioLabel)
            make.bottom.equalTo(layoutMarginsGuide)
        }
    }
}

