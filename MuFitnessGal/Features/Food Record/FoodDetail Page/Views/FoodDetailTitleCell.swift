//
//  FoodDetailTitleCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/6/22.
//

import UIKit

class FoodDetailTitleCell: UITableViewCell {
    static let reuseID = "FoodDetailTitleCell"
    private let titleLabel = UILabel()
    private let brandLabel = UILabel()

    var viewModel: FoodDetailTitleCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleLabelText
            brandLabel.text = viewModel?.brandLabelText
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
extension FoodDetailTitleCell {
    private func configureViews() {
        titleLabel.font = UIFont.h3
        titleLabel.textColor = UIColor.label
        contentView.addSubview(titleLabel)
        
        brandLabel.font = UIFont.bodyBold
        brandLabel.textColor = UIColor.secondaryLabel
        contentView.addSubview(brandLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        brandLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
