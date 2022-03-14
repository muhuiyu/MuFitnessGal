//
//  AddFoodViewController.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/6/22.
//

import UIKit

class AddFoodViewController: ViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    var viewModel: AddFoodViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title = viewModel.viewControllerTitleText
        }
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureGestures()
        configureConstraints()
    }
}
// MARK: - View Config
extension AddFoodViewController {
    private func configureViews() {
        guard let viewModel = viewModel else { return }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchControllerPlaceholderText
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.becomeFirstResponder()
        
        tableView.delegate = self
        tableView.dataSource = self
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
extension AddFoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        let entries = viewModel.displayedRecordEntries
        return entries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodRecordMealFoodCell.reuseID, for: indexPath) as? FoodRecordMealFoodCell
        else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath.row)
        return cell
    }
}
// MARK: - Delegate
extension AddFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print(indexPath)
        
        guard let viewModel = viewModel else { return }
        let viewController = FoodDetailViewController()
        viewController.viewModel = viewModel.detailViewModel(at: indexPath.row)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - SearchController
extension AddFoodViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText != "" {
            viewModel?.filterRecordEntries(for: searchText)
            tableView.reloadData()
        }
        viewModel?.unfilterRecordEntries()
        tableView.reloadData()
    }
}
