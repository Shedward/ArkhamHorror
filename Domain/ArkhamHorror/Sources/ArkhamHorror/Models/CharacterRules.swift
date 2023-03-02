//
//  CharacterRules.swift
//  
//
//  Created by Vladislav Maltsev on 02.03.2023.
//

public struct CharacterRules: Codable {
    public static let `default` = CharacterRules(
        availableMovePoints: 2
    )

    public let availableMovePoints: Int

    init(availableMovePoints: Int) {
        self.availableMovePoints = availableMovePoints
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.availableMovePoints = (try? container.decode(Int.self, forKey: .availableMovePoints)) ?? CharacterRules.default.availableMovePoints
    }
}
