//
//  ___EPISODE___ViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class ___EPISODE___ViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: ___EPISODE___View?
    private let dependencies: Dependencies
    private let data: ___EPISODE___Data

    init(data: ___EPISODE___Data, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        <#Implementation#>
    }
}
