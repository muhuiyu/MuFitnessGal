//
//  FoodRecordViewController.swift
//  Foodie
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

class FoodRecordViewController: ViewController {
    private let tableView = UITableView()
    private lazy var cells: [[UITableViewCell]] = [[]]
    
    var viewModel: FoodRecordViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.viewControllerTitleText
            
            if viewModel.isDailyRecordEmpty {
                viewModel.fetchDailyRecordEntry { error in
                    if let _ = error { return }
                    self.cells.removeAll()
                    self.configureCell()
                    self.tableView.reloadData()
                }
            }
        }
    }

    override init() {
        super.init()
        tabBarItem = UITabBarItem(title: "Food",
                                  image: UIImage(systemName: "list.bullet"),
                                  selectedImage: UIImage(systemName: "list.bullet.indent"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGestures()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
}
// MARK: - Actions
extension FoodRecordViewController {
    private func didTapAddMeal(at mealIndex: Int) {
        let viewController = AddFoodViewController()
        viewController.viewModel = viewModel?.viewModelOfAddFoodViewController(to: mealIndex)
        self.present(viewController.embedInNavgationController(), animated: true) {
            
        }
    }
}
// MARK: - View Config
extension FoodRecordViewController {
    private func configureCell(){
        guard let viewModel = viewModel else { return }
        
        let weekCell = FoodRecordWeekCell()
        weekCell.viewModel = viewModel.viewModelForWeekCell()

        let dailyMacroCell = FoodRecordDailyMacroCell()
        dailyMacroCell.viewModel = viewModel.viewModelForDailyMacroCell()

        cells.append([weekCell])
        cells.append([dailyMacroCell])

        for mealIndex in 0..<viewModel.numberOfMeals {
            var mealCells: [UITableViewCell] = []
            
            let mealHeaderCell = FoodRecordMealHeaderCell()
            mealHeaderCell.viewModel = viewModel.viewModelForMealHeaderCell(for: mealIndex)
            mealCells.append(mealHeaderCell)

            for foodIndex in 0..<viewModel.numberOfFoodRecord(for: mealIndex) {
                let mealFoodCell = FoodRecordMealFoodCell()
                mealFoodCell.viewModel = viewModel.viewModelForMealFoodCell(for: mealIndex, at: foodIndex)
                mealCells.append(mealFoodCell)
            }
            let addFoodCell = LinkCell()
            addFoodCell.linkText = "Add Food"
            
            mealCells.append(addFoodCell)
            cells.append(mealCells)
        }
    }
    private func configureViews() {
        navigationController?.navigationBar.prefersLargeTitles = false

        viewModel?.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodRecordWeekCell.self, forCellReuseIdentifier: FoodRecordWeekCell.reuseID)
        tableView.register(FoodRecordDailyMacroCell.self, forCellReuseIdentifier: FoodRecordDailyMacroCell.reuseID)
        tableView.register(FoodRecordMealHeaderCell.self, forCellReuseIdentifier: FoodRecordMealHeaderCell.reuseID)
        tableView.register(FoodRecordMealFoodCell.self, forCellReuseIdentifier: FoodRecordMealFoodCell.reuseID)
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
extension FoodRecordViewController: UITableViewDataSource {
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
extension FoodRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let mealIndex = indexPath.section - 2           // remove the first two sections and title
        let foodIndexInMeal = indexPath.row - 1
        guard mealIndex >= 0, foodIndexInMeal >= 0 else { return }
        
        guard let tableViewModel = viewModel else { return }
        if tableViewModel.didTapAddMeal(ofMeal: mealIndex, at: foodIndexInMeal) {
            self.didTapAddMeal(at: mealIndex)
        } else {
            guard
                let foodItem = tableViewModel.getFoodItem(ofMeal: mealIndex, at: foodIndexInMeal),
                let recordEntry = tableViewModel.getRecordEntry(ofMeal: mealIndex, at: foodIndexInMeal)
            else { return }
            let viewController = FoodDetailViewController()
            viewController.viewModel = FoodDetailViewModel(foodItemEntry: foodItem, recordEntry: recordEntry)
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
// MARK: - Delegate from VIew Model
extension FoodRecordViewController: FoodRecordViewModelDelegate {
    func foodRecordViewModelDidReqestToReloadData(_ viewModel: FoodRecordViewModel) {
        configureCell()
        tableView.reloadData()
    }
}
