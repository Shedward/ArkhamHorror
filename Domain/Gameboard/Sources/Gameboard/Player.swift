//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 24.04.2022.
//

import Common
import Prelude

class Player {
    typealias BagItem = Any

    enum HealthTag {}
    typealias Health = Tagged<HealthTag, Int>

    enum MindTag {}
    typealias Mind = Tagged<MindTag, Int>

    enum SkillLevelTag {}
    typealias SkillLevel = Tagged<SkillLevelTag, Int>

    enum RemnantsCountTag {}
    typealias RemnantsCount = Tagged<RemnantsCountTag, Int>

    enum CluesCountTag {}
    typealias CluesCount = Tagged<CluesCountTag, Int>


    struct InitialStats 
        let maxHealth: Health
        let maxMind: Mind
        let skillLimits: [Skill: SkillLevel]

        let bag: [BagItem]
    }

    struct Personality {
        let name: String
    }

    enum Property {
        case health
        case mind
        case skillLevel
        case remnantsCount
        case cluesCount
    }

    var health: Health
    var mind: Mind
    var skillLevel: [Skill: SkillLevel]

    var remnantsCount: RemnantsCount
    var cluesCount: CluesCount

    var bag: [BagItem]
}
