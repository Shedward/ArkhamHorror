//
//  PlayersEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import ArkhamHorror
import DesignSystem
import simd
import CoreGraphics

final class PlayersEpisode: GameEpisode<PlayersViewModel> {
    private var playersCollection: Collection<PlayerCell.Data, PlayerCell>?
    private var playerObjects: [Scenes.Player] = []

    override func willBegin() {
        let charactersCollection = Collection(
            size: CGSize(width: overlaySize.width, height: PlayerCell.size.height),
            of: PlayerCell.self,
            layout: CenteredRowLayout(itemSize: PlayerCell.size, spacing: 16)
        )
        self.playersCollection = charactersCollection
        let charactersContainer = AlignedToBottom(charactersCollection, size: overlaySize)
        addView(charactersContainer)
    }
}

extension PlayersEpisode: PlayersView {
    func displayPlayerCells(_ characters: [PlayerCell.Data]) {
        playersCollection?.dataSource = ArrayCollectionDataSource(data: characters).asAny()
        layout()
    }

    func displayPlayers(_ players: [PlayerData]) {
        playerObjects = players.map { playerData in
            let player = Scenes.Player(id: playerData.id, color: playerData.color)
            addObject(player)
            player.moveTo(playerData.position, animated: false)
            return player
        }
    }

    func movePlayer(_ id: ArkhamHorror.Player.ID, along path: [vector_float2]) {
        for pathPoint in path {
            playerObjects[id: id]?.moveTo(pathPoint, animated: true)
        }
    }

    func presentActions(_ data: SelectActionData) {
        let cell = playersCollection?.cells.first { $0.id == data.player.id }
        guard let anchor = cell ?? playersCollection else { return }
        let episode = episodes.selectAction(data: data, from: anchor)
        startChildEpisode(episode)
    }
}

extension PlayersEpisode {
    struct PlayerData {
        let id: ArkhamHorror.Player.ID
        let color: UColor
        let position: vector_float2
    }
}
