//
//  SearchLabelModalViewController.swift
//  Lango
//
//  Created by Mu Yu on 12/2/21.
//

import UIKit

//protocol SearchLabelModalViewControllerDelegate: class {
//    func searchLabelModalViewController(_ controller: SearchLabelModalViewController, didSelectItem item: WordLabel)
//    func searchLabelModalViewControllerDidRequestDismiss(_ controller: SearchLabelModalViewController)
//}
//
//class SearchLabelModalViewController: ViewController {
//    private let tableView = UITableView()
//    private let searchController = UISearchController(searchResultsController: nil)
//    private var isSearchBarEmpty: Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !isSearchBarEmpty
//    }
//
//    private var filteredData: [WordLabel] = []
//    private let items: [WordLabel] = WordLabel.allCases
//    var searchBarPlaceholder: String? {
//        didSet {
//            guard let searchBarPlaceholder = searchBarPlaceholder else { return }
//            searchController.searchBar.placeholder = searchBarPlaceholder
//        }
//    }
//
//    weak var delegate: SearchLabelModalViewControllerDelegate?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        configureViews()
//        configureConstraints()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationItem.hidesSearchBarWhenScrolling = false
//    }
//}
//// MARK: - Actions
//extension SearchLabelModalViewController {
//    private func filterContentForSearchText(_ searchText: String) {
//        self.filteredData = items.filter({ (item: WordLabel) -> Bool in
//            return item.rawValue.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//    @objc
//    private func didTapDismiss() {
//        delegate?.searchLabelModalViewControllerDidRequestDismiss(self)
//    }
//}
//// MARK: - View Config
//extension SearchLabelModalViewController {
//    private func configureViews() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDismiss))
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        view.addSubview(tableView)
//    }
//    private func configureConstraints() {
//        tableView.snp.remakeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}
//
//// MARK: - Data Source
//extension SearchLabelModalViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.isFiltering {
//            return filteredData.count
//        }
//        else {
//            return items.count
//        }
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let type: UITableViewCell.CellStyle
//        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
//        let item: WordLabel
//        if self.isFiltering { item = filteredData[indexPath.row] }
//        else { item = items[indexPath.row] }
//        cell.textLabel?.text = item.rawValue
//        return cell
//    }
//}
//
//// MARK: - Delegate
//extension SearchLabelModalViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        let selectedItem: WordLabel
//        if self.isFiltering { selectedItem = filteredData[indexPath.row] }
//        else { selectedItem = items[indexPath.row] }
//        delegate?.searchLabelModalViewController(self, didSelectItem: selectedItem)
//    }
//}
//// MARK: - Search Result
//extension SearchLabelModalViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text!)
//    }
//}
//
