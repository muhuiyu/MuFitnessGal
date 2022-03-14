//
//  DailyExerciseLogCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/2/22.
//

import UIKit

class DailyExerciseLogCell: UITableViewCell {
    static let reuseID = "DailyExerciseLogCell"
    
    private let dateStackView = UIStackView()
    private let weekdayLabel = UILabel()
    private let dateLabel = UILabel()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let timeLabel = UILabel()
    
    var viewModel: DailyExerciseLogCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.titleLabelText
            subtitleLabel.text = viewModel.subtitleLabelText
            weekdayLabel.text = viewModel.weekdayName
            dateLabel.text = viewModel.dayString
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
extension DailyExerciseLogCell {
    private func configureViews() {
        weekdayLabel.font = UIFont.small
        weekdayLabel.textColor = UIColor.secondaryLabel
        dateStackView.addArrangedSubview(weekdayLabel)
        
        dateLabel.font = UIFont.h3
        dateLabel.textColor = UIColor.label
        dateStackView.addArrangedSubview(dateLabel)
        
        dateStackView.spacing = Constants.spacing.trivial
        dateStackView.alignment = .center
        dateStackView.axis = .vertical
        contentView.addSubview(dateStackView)
        
        titleLabel.font = UIFont.bodyBold
        titleLabel.textColor = UIColor.label
        contentStackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.font = UIFont.small
        subtitleLabel.textColor = UIColor.label
        subtitleLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(subtitleLabel)
        
        contentStackView.spacing = Constants.spacing.small
        contentStackView.alignment = .leading
        contentStackView.axis = .vertical
        contentView.addSubview(contentStackView)
        
        timeLabel.text = "12 min"
        timeLabel.font = UIFont.small
        timeLabel.textColor = UIColor.secondaryLabel
        contentView.addSubview(timeLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        dateStackView.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentView.layoutMarginsGuide)
        }
        contentStackView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentView.layoutMarginsGuide).offset(60)
            make.trailing.greaterThanOrEqualTo(timeLabel.snp.leading).offset(-Constants.spacing.small)
        }
        timeLabel.snp.remakeConstraints { make in
            make.trailing.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
