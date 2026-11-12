//
//  MainModule.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2023.
//

extension Episodes {
    @MainActor
    func main() -> BaseGameEpisode {
        MainEpisode(episodes: self)
    }
}
