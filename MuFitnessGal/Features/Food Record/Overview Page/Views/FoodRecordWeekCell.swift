//
//  FoodRecordWeekCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordWeekCell: UITableViewCell {
    static let reuseID = "FoodRecordWeekCell"
    
    private let monthYearLabel = UILabel()
    private let stackView = UIStackView()
    
    var viewModel: FoodRecordWeekCellViewModel? {
        didSet {
            configureDateItems()
            monthYearLabel.text = viewModel?.monthAndYearString
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
// MARK: - View Config
extension FoodRecordWeekCell {
    private func configureDateItems() {
        guard let viewModel = viewModel else { return }
        stackView.removeAllArrangedSubviews()
        
        for i in 0..<7 {
            let item = FoodRecordWeekItemView()
            item.viewModel = viewModel.viewModel(at: i)
            item.isSelected = (i == viewModel.selectedIndex)
            stackView.addArrangedSubview(item)
        }
    }
    private func configureViews() {
        contentView.backgroundColor = UIColor.white
        
        configureDateItems()
        
        monthYearLabel.textColor = UIColor.label
        monthYearLabel.font = UIFont.small
        contentView.addSubview(monthYearLabel)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        monthYearLabel.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(monthYearLabel.snp.bottom).offset(Constants.spacing.small)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}
