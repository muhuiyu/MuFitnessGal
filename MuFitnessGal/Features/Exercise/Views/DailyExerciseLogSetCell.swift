//
//  DailyExerciseLogSetCell.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import Foundation
import UIKit

class DailyExerciseLogSetCell: UITableViewCell {
    static let reuseID = "DailyExerciseLogSetCell"

    private let setCountLabel = UILabel()
    
    private let stackView = UIStackView()
    private let weightItemView = DailyExerciseLogSetCellItemView()
    private let repItemView = DailyExerciseLogSetCellItemView()
    private let noteItemView = DailyExerciseLogSetCellItemView()
    
    var viewModel: DailyExerciseLogSetCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            setCountLabel.text = viewModel.setLabelText
            weightItemView.label = viewModel.weightLabelText
            weightItemView.value = viewModel.weightValueText
            repItemView.label = viewModel.repLabelText
            repItemView.value = viewModel.repValueText
            noteItemView.label = viewModel.noteLabelText
            noteItemView.value = viewModel.noteValueText
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
extension DailyExerciseLogSetCell {
    private func configureViews() {
        setCountLabel.font = UIFont.small
        contentView.addSubview(setCountLabel)
        
        stackView.addArrangedSubview(weightItemView)
        stackView.addArrangedSubview(repItemView)
        stackView.addArrangedSubview(noteItemView)
        
        stackView.axis = .horizontal
        stackView.spacing = Constants.spacing.small
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        setCountLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        stackView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(setCountLabel.snp.trailing).offset(Constants.spacing.large)
        }
    }
}
