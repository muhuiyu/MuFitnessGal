//
//  LabelSegmentControllCell.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 16/1/21.
//

import UIKit

class LabelSegmentControllCell: UITableViewCell {
    static let reuseID = "LabelSegmentControllCell"
    
    var label: String? {
        get { return labelLabel.text }
        set { labelLabel.text = newValue }
    }
    var segmentControlItems: [String]? {
        didSet {
            segmentControl.removeAllSegments()
            guard let segmentControlItems = segmentControlItems else { return }
            for (i, item) in segmentControlItems.enumerated() {
                segmentControl.insertSegment(withTitle: item, at: i, animated: false)
            }
            segmentControl.selectedSegmentIndex = 0
        }
    }
    private var segmentControl = UISegmentedControl(items: ["default 1", "default 2"])
    private let labelLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension LabelSegmentControllCell {
    @objc
    private func segmentValueDidChanged(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
}
// MARK: - View Config
extension LabelSegmentControllCell {
    private func configureViews() {
        labelLabel.textColor = UIColor.basic.dark
        labelLabel.font = UIFont.body
        contentView.addSubview(labelLabel)
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueDidChanged(_:)), for: .valueChanged)
        contentView.addSubview(segmentControl)
    }
    
    private func configureConstraints() {
        labelLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.top.equalTo(contentView.layoutMarginsGuide)
        }
        segmentControl.snp.remakeConstraints { make in
            make.top.equalTo(labelLabel.snp.bottom).offset(Constants.spacing.small)
            make.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
}
