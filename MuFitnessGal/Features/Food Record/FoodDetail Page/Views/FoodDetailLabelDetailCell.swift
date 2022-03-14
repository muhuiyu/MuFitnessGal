//
//  FoodDetailLabelDetailCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import UIKit

class FoodDetailLabelDetailCell: UITableViewCell {
    static let reuseID = "FoodDetailLabelDetailCell"
    
    private let labelLabel = UILabel()
    private let detailView = FoodDetailLabelDetailView()
    
    var viewModel: FoodDetailLabelDetailCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            labelLabel.text = viewModel.labelLabelText
            detailView.viewModel = viewModel.viewModelOfLabelDetail()
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
// MARK: - Actions
extension FoodDetailLabelDetailCell {
    
}
// MARK: - View Config
extension FoodDetailLabelDetailCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.label
        labelLabel.font = UIFont.body
        labelLabel.textAlignment = .left
        contentView.addSubview(labelLabel)
        contentView.addSubview(detailView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.top.bottom.equalTo(detailView)
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.trailing.equalTo(detailView.snp.leading)
        }
        detailView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.width.equalTo(150)
        }
    }
}
