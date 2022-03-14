//
//  FoodDetailViewController.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/6/22.
//

import UIKit

class FoodDetailViewController: ViewController {
    private let tableView = UITableView()
//    private let pickerView = CustomPickerView()
    private lazy var cells: [[UITableViewCell]] = []
   
    var viewModel: FoodDetailViewModel? {
        didSet {
            configureCells()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapDone))
        }
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
// MARK: - Actions
extension FoodDetailViewController {
    @objc
    private func didTapDone() {
        
    }
}
// MARK: - View Config
extension FoodDetailViewController {
    private func configureCells() {
        guard let viewModel = viewModel else { return }
        cells.removeAll()

        let titleCell = FoodDetailTitleCell()
        titleCell.viewModel = viewModel.viewModelOfTitleCell()
        cells.append([titleCell])
        
        let macroCell = FoodDetailMacroCell()
        macroCell.viewModel = viewModel.viewModelOfMacroCell()
        
        let unitCell = FoodDetailLabelDetailCell()
        unitCell.viewModel = viewModel.viewModelOfUnitCell()
        
        let portionCell = FoodDetailLabelDetailCell()
        portionCell.viewModel = viewModel.viewModelOfPortionCell()
        
        let mealCell = FoodDetailLabelDetailCell()
        mealCell.viewModel = viewModel.viewModelOfMealCell()
        
        cells.append([macroCell, unitCell, portionCell, mealCell])
        
        // select unit & portion & meal
        // view nutrition list
    }
    private func configureViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FoodDetailTitleCell.self, forCellReuseIdentifier: FoodDetailTitleCell.reuseID)
        tableView.register(FoodDetailMacroCell.self, forCellReuseIdentifier: FoodDetailMacroCell.reuseID)
        tableView.register(FoodDetailLabelDetailCell.self, forCellReuseIdentifier: FoodDetailLabelDetailCell.reuseID)
        
    }
    private func configureGestures() {
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
// MARK: - Data Source
extension FoodDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
}
// MARK: - Delegate
extension FoodDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
