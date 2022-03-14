//
//  FoodRecordWeekItemView.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordWeekItemView: UIView {
    
    private let dayLabel = UILabel()
    private let dateLabel = UILabel()
    
    var viewModel: FoodRecordWeekItemViewModel? {
        didSet {
            dayLabel.text = viewModel?.weekdayName
            dateLabel.text = viewModel?.dayNumber
        }
    }
    
    var day: String? {
        get { return dayLabel.text }
        set { dayLabel.text = newValue }
    }
    
    var date: AppDate {
        didSet {
            dateLabel.text = String(date.day)
        }
    }
    var isSelected: Bool = false {
        didSet {
            reconfigureStyle()
        }
    }
    
    override init(frame: CGRect = .zero) {
        self.date = AppDate(date: Date())
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
extension FoodRecordWeekItemView {
    private func reconfigureStyle() {
        if isSelected {
            dayLabel.textColor = UIColor.systemBlue
            dayLabel.font = UIFont.descBold
            dateLabel.textColor = UIColor.systemBlue
            dateLabel.font = UIFont.smallBold
        } else {
            dayLabel.textColor = UIColor.label
            dayLabel.font = UIFont.desc
            dateLabel.textColor = UIColor.label
            dateLabel.font = UIFont.small
        }
    }

    private func configureViews() {
        dayLabel.textColor = UIColor.label
        dayLabel.text = "SUN"
        dayLabel.font = UIFont.desc
        addSubview(dayLabel)
        
        dateLabel.font = UIFont.small
        dateLabel.text = "1"
        dateLabel.textColor = UIColor.label
        addSubview(dateLabel)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        dayLabel.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        dateLabel.snp.remakeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(Constants.spacing.trivial)
            make.centerX.equalTo(dayLabel)
            make.bottom.equalToSuperview()
        }
    }
}

