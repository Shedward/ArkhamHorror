//
//  GameEpisodeViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 20.02.2023.
//

protocol GameEpisodeViewModel {
    associatedtype Episode

    var episode: Episode? { get set }

    func didBegin() async
    func willEnd()
}

extension GameEpisodeViewModel {
    func didBegin() async {
    }

    func willEnd() {
    }
}
