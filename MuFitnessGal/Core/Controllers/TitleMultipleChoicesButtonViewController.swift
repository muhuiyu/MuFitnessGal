//
//  TitleMultipleChoicesButtonViewController.swift
//  Intellect prototype
//
//  Created by Mu Yu on 18/2/21.
//

import UIKit

class TitleMultipleChoicesButtonViewController: ViewController {
    
    private let headerContainer = HeaderWithLargeTitleView()
    private let tableView = UITableView()
    private let nextButton = TextButton(buttonType: .primary)
    
    var headerText: String? {
        get { return headerContainer.header }
        set { headerContainer.header = newValue }
    }
    var titleText: String? {
        get { return headerContainer.text }
        set { headerContainer.text = newValue }
    }
    var subtitleText: String? {
        get { return headerContainer.subtitle }
        set { headerContainer.subtitle = newValue }
    }
    var selectionLimit: Int = 1 {
        didSet {
            if selectionLimit > 1 { tableView.allowsMultipleSelection = true }
            else { tableView.allowsMultipleSelection = false }
            tableView.reloadData()
        }
    }
    var isButtonHidden: Bool = false {
        didSet {
            nextButton.isHidden = isButtonHidden
        }
    }
    var buttonType: TextButton.ButtonType? {
        get { return nextButton.buttonType }
        set { nextButton.buttonType = newValue ?? .primary }
    }
    var buttonText: String? {
        get { return nextButton.text }
        set { nextButton.text = newValue }
    }
    var tapHandler: (() -> Void)? {
        didSet {
            nextButton.tapHandler = tapHandler
        }
    }
    let isNavigationBarHidden: Bool
    let items: [String]
    init(isNavigationBarHidden: Bool = false, items: [String]) {
        self.isNavigationBarHidden = isNavigationBarHidden
        self.items = items
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MultipleChoiceCell.self, forCellReuseIdentifier: MultipleChoiceCell.reuseID)
        configureViews()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(self.isNavigationBarHidden, animated: animated)
    }
}
// MARK: - View Config
extension TitleMultipleChoicesButtonViewController {
    private func configureViews() {
        view.addSubview(headerContainer)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        view.addSubview(tableView)
        nextButton.isEnable = false
        view.addSubview(nextButton)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        headerContainer.snp.remakeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerContainer.snp.bottom).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.bottom.equalTo(nextButton.snp.top).offset(-Constants.spacing.small)
        }
        nextButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constants.spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
}
// MARK: - Data Source
extension TitleMultipleChoicesButtonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceCell.reuseID, for: indexPath) as? MultipleChoiceCell else {
            fatalError()
        }
        cell.labelText = items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            if self.selectionLimit == 1 {
                guard let previousCell = tableView.cellForRow(at: selectedRows[0]) as? MultipleChoiceCell else { return nil }
                previousCell.isCellSelected = false
                nextButton.isEnable = true
                return indexPath
            }
            else if (selectedRows.count == self.selectionLimit) { return nil }
            else {
                nextButton.isEnable = true
                return indexPath
            }
        }
        nextButton.isEnable = true
        return indexPath
    }
}
// MARK: - Delegate
extension TitleMultipleChoicesButtonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MultipleChoiceCell else { return }
        cell.isCellSelected = !cell.isCellSelected
    }
}

