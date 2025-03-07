import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
    
    let heroesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListHeroesTableViewCell.self, forCellReuseIdentifier: "ListHeroesTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        tableView.accessibilityIdentifier = AccessibilityIdentifier.heroesTableView
        return tableView
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search heroes..."
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    private let searchSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
        configureSearchBar()
    }
    
    private func addSubviews() {
        addSubview(heroesTableView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.topAnchor.constraint(equalTo: topAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureSearchBar() {
         searchController.searchBar.addSubview(searchSpinner)
         searchSpinner.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             searchSpinner.trailingAnchor.constraint(equalTo: searchController.searchBar.trailingAnchor, constant: -16),
             searchSpinner.centerYAnchor.constraint(equalTo: searchController.searchBar.centerYAnchor)
         ])
     }

     func startLoading() {
         searchSpinner.startAnimating()
     }

     func stopLoading() {
         searchSpinner.stopAnimating()
     }
}
