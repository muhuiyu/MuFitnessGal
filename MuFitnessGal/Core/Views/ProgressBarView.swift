//
//  ProgressBarView.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 13/1/21.
//

import UIKit

class ProgressBarView: UIView {
    
    private let backgroundView = UIView()
    private let activeView = UIView()
    
    var themeColor: UIColor? {
        get { return activeView.backgroundColor}
        set { activeView.backgroundColor = newValue }
    }
    var barDefaultColor: UIColor? {
        get { return backgroundView.backgroundColor}
        set { backgroundView.backgroundColor = newValue }
    }
    
    var percentage: Double {
        didSet {
            reconfigureConstraints()
        }
    }
    
    init(frame: CGRect = .zero, percentage: Double) {
        self.percentage = percentage
        super.init(frame: frame)
        
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension ProgressBarView {
    func updateProgressBar(changeToPercentage percentage: Double, withDuration duration: TimeInterval = 0.25) {
        self.percentage = percentage
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
// MARK: - View Config
extension ProgressBarView {
    private func configureViews() {
        activeView.layer.cornerRadius = Constants.progressBar.cornerRadius
        activeView.backgroundColor = UIColor.brand.secondary
        backgroundView.layer.cornerRadius = Constants.progressBar.cornerRadius
        backgroundView.addSubview(activeView)
        backgroundView.backgroundColor = UIColor.tertiarySystemGroupedBackground
        addSubview(backgroundView)
    }
    private func configureConstraints() {
        activeView.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(percentage)
        }
        backgroundView.snp.remakeConstraints { make in
            make.height.equalTo(Constants.progressBar.height)
            make.edges.equalToSuperview()
        }
    }
    private func reconfigureConstraints() {
        activeView.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(percentage)
        }
    }
}
