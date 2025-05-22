//
//   TopRatedMoviesViewModel.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol TopRatedMoviesViewModelProtocol {
    var movies: [MovieEntity] { get }
    var filteredMovies: [MovieEntity] { get }
    var onMoviesUpdated: (() -> Void)? { get set }
    var onError: ((AppError) -> Void)? { get set }

    func fetchTopRated()
    func filter(with query: String)
}

final class TopRatedMoviesViewModel: TopRatedMoviesViewModelProtocol {
    private let fetchUseCase: FetchTopRatedMoviesUseCaseProtocol

    private(set) var movies: [MovieEntity] = []
    #if DEBUG
        func setMoviesForTest(_ movies: [MovieEntity]) {
            self.movies = movies
            filteredMovies = movies
        }
    #endif
    private(set) var filteredMovies: [MovieEntity] = []

    var onMoviesUpdated: (() -> Void)?
    var onError: ((AppError) -> Void)?

    init(fetchUseCase: FetchTopRatedMoviesUseCaseProtocol) {
        self.fetchUseCase = fetchUseCase
    }

    func fetchTopRated() {
        fetchUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(movies):
                    self?.movies = movies
                    self?.filteredMovies = movies
                    self?.onMoviesUpdated?()
                case let .failure(error):
                    self?.onError?(error)
                }
            }
        }
    }

    func filter(with query: String) {
        if query.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        onMoviesUpdated?()
    }
}
