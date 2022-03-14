//
//  LoadingTextImageViewController.swift
//  Lango
//
//  Created by Mu Yu on 31/1/21.
//

import UIKit

class LoadingTextImageViewController: ViewController {
    
    private let stackView = UIStackView()
    private let illustationImageView = UIImageView()
    private let textLabel = UILabel()
    
    var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    var image: UIImage? {
        get { return illustationImageView.image }
        set { illustationImageView.image = newValue }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    
}
// MARK: - View Config
extension LoadingTextImageViewController {
    private func configureViews() {
        illustationImageView.contentMode = .scaleAspectFit
        illustationImageView.image = UIImage(named: "welcomeIllustration")
        stackView.addArrangedSubview(illustationImageView)
        textLabel.textColor = UIColor.text.subtle
        textLabel.font = UIFont.small
        stackView.addArrangedSubview(textLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.spacing.medium
        view.addSubview(stackView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        illustationImageView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.imageSize.illustation)
        }
        stackView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
