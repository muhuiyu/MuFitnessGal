//
//  ExerciseDayDetailViewController.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/4/22.
//

import UIKit

protocol ExerciseDayDetailViewControllerDelegate: AnyObject {
    func exerciseDayDetailViewControllerDidRequestDismiss(_ controller: ExerciseDayDetailViewController)
}

class ExerciseDayDetailViewController: ViewController {
    
    private let tableView = UITableView()
    private lazy var cells: [[UITableViewCell]] = []

    var viewModel: ExerciseDayDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.viewControllerTitleText
            cells.removeAll()
            cells = viewModel.configureCells()
        }
    }
    
    weak var delegate: ExerciseDayDetailViewControllerDelegate?
    
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
// MARK: - Actions
extension ExerciseDayDetailViewController {
    @objc
    private func didTapDone() {
        delegate?.exerciseDayDetailViewControllerDidRequestDismiss(self)
    }
}
// MARK: - View Config
extension ExerciseDayDetailViewController {
    private func configureViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LabelDetailCell.self, forCellReuseIdentifier: LabelDetailCell.reuseID)
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
extension ExerciseDayDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let view = UIView()
            view.backgroundColor = UIColor.secondarySystemBackground
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return Constants.spacing.medium
        }
    }

}

// MARK: - Delegate
extension ExerciseDayDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print(indexPath)
    }
}

