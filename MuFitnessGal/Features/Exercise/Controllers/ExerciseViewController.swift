//
//  ExerciseViewController.swift
//  Foodie
//
//  Created by Mu Yu on 3/2/22.
//

import UIKit

class ExerciseViewController: ViewController {
    
    private let tableView = UITableView()
    
    var viewModel: ExerciseViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.viewControllerTitleText
            tableView.reloadData()
        }
    }
   
    override init() {
        super.init()
        tabBarItem = UITabBarItem(title: "Exercise",
                                  image: UIImage(systemName: "circle"),
                                  selectedImage: UIImage(systemName: "circle.fill"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGestures()
        configureConstraints()
    }
}
// MARK: - Actions
extension ExerciseViewController {
    @objc private func didTapAdd() {
        
    }

}
// MARK: - View Config
extension ExerciseViewController {
    private func configureViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        title = "Exercise"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DailyExerciseLogCell.self, forCellReuseIdentifier: DailyExerciseLogCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Data Source
extension ExerciseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.countOftableViewRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyExerciseLogCell.reuseID, for: indexPath) as? DailyExerciseLogCell,
            let viewModel = viewModel
        else { return UITableViewCell() }
        
        cell.viewModel = viewModel.cellViewModel(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - Delegate
extension ExerciseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let viewModel = viewModel else { return }
        let viewController = ExerciseDayDetailViewController()
        viewController.viewModel = viewModel.viewModel(at: indexPath.row)
        viewController.isModalInPresentation = true
        viewController.delegate = self
        self.present(viewController.embedInNavgationController(), animated: true) {

        }
    }
}
// MARK: - Delegate from DetailViewController
extension ExerciseViewController: ExerciseDayDetailViewControllerDelegate {
    func exerciseDayDetailViewControllerDidRequestDismiss(_ controller: ExerciseDayDetailViewController) {
        self.dismiss(animated: true) {
            
        }
    }
}
