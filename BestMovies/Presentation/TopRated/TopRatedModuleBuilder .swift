//
//  TopRatedModuleBuilder .swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import UIKit

enum TopRatedModuleBuilder {
    static func build() -> UIViewController {
        let networkClient = NetworkClient(
            host: "https://api.themoviedb.org/3",
            apiKey: "9432659d4637f40ba0230835d50f84fc"
        )

        let movieService = MovieService(networkClient: networkClient)

        let movieRepository = MovieRepository(service: movieService)

        let topRatedUseCase = FetchTopRatedMoviesUseCase(repository: movieRepository)

        let viewModel = TopRatedMoviesViewModel(fetchUseCase: topRatedUseCase)

        let viewController = TopRatedMoviesViewController(viewModel: viewModel)

        return viewController
    }
}
