//
//  ___EPISODE___ViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class ___EPISODE___ViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: ___EPISODE___EpisodeProtocol?
    private let dependencies: Dependencies
    private let output: ___EPISODE___Output

    init(dependencies: Dependencies, output: ___EPISODE___Output) {
        self.dependencies = dependencies
        self.output = output
    }

    func didBegin() {
        <#Implementation#>
    }
}
