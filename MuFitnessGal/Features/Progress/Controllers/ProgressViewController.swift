//
//  ProgressViewController.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import UIKit

class ProgressViewController: ViewController {
    
    var viewModel: ProgressViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.viewControllerTitleText
        }
    }
    
    override init() {
        super.init()
        tabBarItem = UITabBarItem(title: "Progress",
                                  image: UIImage(systemName: "chart.bar"),
                                  selectedImage: UIImage(systemName: "chart.bar.fill"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGestures()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}
// MARK: - View Config
extension ProgressViewController {
    private func configureViews() {
        
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        
    }
}

