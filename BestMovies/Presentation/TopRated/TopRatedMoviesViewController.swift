//
//  TopRatedMoviesViewController.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation
import UIKit

final class TopRatedMoviesViewController: UIViewController {
    private var viewModel: TopRatedMoviesViewModelProtocol
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Init

    init(viewModel: TopRatedMoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearch()
        bindViewModel()
        fetchData()
        retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
    }

    // MARK: - Setup

    private func setupUI() {
        title = "Top Rated"
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseID)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        view.addSubview(retryButton)

        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.emptyLabel.isHidden = !self.viewModel.filteredMovies.isEmpty
            }
        }

        viewModel.onError = { [weak self] error in
            guard let self else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.emptyLabel.isHidden = false
                self.retryButton.isHidden = false
                self.showError(error.localizedDescription)
            }
        }
    }

    @objc private func didTapRetry() {
        retryButton.isHidden = true
        emptyLabel.isHidden = true
        fetchData()
    }

    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true        
    }

    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel.fetchTopRated()
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No results"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.accessibilityIdentifier = "emptyLabel"
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "retryButton"
        return button
    }()
}

extension TopRatedMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.filter(with: query)
    }
}

// MARK: - UITableViewDataSource

extension TopRatedMoviesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.filteredMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }

        let movie = viewModel.filteredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}
