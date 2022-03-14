//
//  SearchWordModalViewController.swift
//  Lango
//
//  Created by Mu Yu on 6/2/21.
//

import UIKit

//protocol SearchWordModalViewControllerDelegate: class {
//    func searchWordModalViewController(_ controller: SearchWordModalViewController, didSelectItem item: WordEntry)
//    func searchWordModalViewControllerDidRequestDismiss(_ controller: SearchWordModalViewController)
//}
//
//class SearchWordModalViewController: ViewController {
//    private let tableView = UITableView()
//    private let searchController = UISearchController(searchResultsController: nil)
//    private var isSearchBarEmpty: Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !isSearchBarEmpty
//    }
//
//    private var filteredData: [WordEntry] = []
//    private let items: [WordEntry]
//    private let modalCellType: SearchWordModelViewControllerType
//    enum SearchWordModelViewControllerType {
//        case `default`
//        case subtitle
//        case value
//    }
//    private let mainTextType: WordArributeType
//    enum WordArributeType {
//        case meaning
//        case value
//    }
//    var searchBarPlaceholder: String? {
//        didSet {
//            guard let searchBarPlaceholder = searchBarPlaceholder else { return }
//            searchController.searchBar.placeholder = searchBarPlaceholder
//        }
//    }
//
//    weak var delegate: SearchWordModalViewControllerDelegate?
//
//    init(items: [WordEntry], modalCellType: SearchWordModelViewControllerType = .default, mainTextType: WordArributeType = .value) {
//        self.items = items
//        self.modalCellType = modalCellType
//        self.mainTextType = mainTextType
//        super.init()
//    }
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
//extension SearchWordModalViewController {
//    private func filterContentForSearchText(_ searchText: String) {
//        self.filteredData = items.filter({ (item: WordEntry) -> Bool in
//            return item.value.lowercased().contains(searchText.lowercased()) || item.meaning.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//    @objc
//    private func didTapDismiss() {
//        delegate?.searchWordModalViewControllerDidRequestDismiss(self)
//    }
//}
//// MARK: - View Config
//extension SearchWordModalViewController {
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
//extension SearchWordModalViewController: UITableViewDataSource {
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
//        switch self.modalCellType {
//            case .default: type = .default
//            case .subtitle: type = .subtitle
//            case .value: type = .value1
//        }
//        let cell = UITableViewCell(style: type, reuseIdentifier: .none)
//        let item: WordEntry
//        if self.isFiltering { item = filteredData[indexPath.row] }
//        else { item = items[indexPath.row] }
//
//        switch self.mainTextType {
//        case .value:
//            cell.textLabel?.text = item.value
//            cell.detailTextLabel?.text = item.meaning
//        case .meaning:
//            cell.textLabel?.text = item.meaning
//            cell.detailTextLabel?.text = item.value
//        }
//        return cell
//    }
//}
//
//// MARK: - Delegate
//extension SearchWordModalViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        let selectedItem: WordEntry
//        if self.isFiltering { selectedItem = filteredData[indexPath.row] }
//        else { selectedItem = items[indexPath.row] }
//        delegate?.searchWordModalViewController(self, didSelectItem: selectedItem)
//    }
//}
//// MARK: - Search Result
//extension SearchWordModalViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text!)
//    }
//}
