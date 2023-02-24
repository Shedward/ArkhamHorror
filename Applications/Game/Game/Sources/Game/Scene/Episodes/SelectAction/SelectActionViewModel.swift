//
//  SelectActionViewModel.swift
//  
//
//  Created by Vladislav Maltsev.
//

final class SelectActionViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: SelectActionEpisodeProtocol?
    private let dependencies: Dependencies
    private let output: SelectActionOutput

    init(dependencies: Dependencies, output: SelectActionOutput) {
        self.dependencies = dependencies
        self.output = output
    }

    func didBegin() {
    }
}
