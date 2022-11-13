//
//  ConfigureCharacterView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI
import Prelude

struct ConfigureCharacterView: View {

    let name: String
    let profession: String
    let story: String
    let roles: [(name: String, description: String)]
    let stats: (health: Int, mind: Int)
    let skills: [(icon: String, value: Int)]

    static func mock() -> ConfigureCharacterView {
        ConfigureCharacterView(
            name: "John Summerfield",
            profession: "Policeman",
            story: """
            The end is near and John is feeling it. It's been a long time\
            since he feelt anything else than morbid horror of existence in\
            this world with cruel evidences of unknown
            """,
            roles: [
                ("Protector", "You help your allies to survive damage, and avoid dangers"),
                ("Trickster", "You have uniqie skills to solve !pretty! specific problems")
            ],
            stats: (5, 6),
            skills: [
                ("observation", 2),
                ("influence", 5),
                ("strength", 4),
                ("lore", 3),
                ("will", 2)
            ]
        )
    }

    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(spacing: 12) {
                CharacterPortrait(size: .big)
                VStack {
                    Text(name)
                        .styled(.Design.Menu.h2)
                        .multilineTextAlignment(.center)
                    Text(profession)
                        .styled(.Design.Menu.story)
                }
                .padding(.bottom)
                MenuHSeparator()
                    .frame(maxWidth: 50)
                Text(story)
                    .styled(.Design.Menu.story)
                if !roles.isEmpty {
                    MenuHSeparator()
                        .frame(maxWidth: 50)
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(roles, id: \.name) { role in
                            let name = Localized.string("%@ - ", arguments: role.name)
                            let formattedName = AttributedString(name)
                                .styled(.Design.Menu.keyword)
                            let formattedDescription = AttributedString(role.description)
                                .styled(.Design.Menu.body)
                            Text(formattedName + formattedDescription)
                        }
                    }
                    .padding(.top)
                }
            }
            .frame(maxWidth: CharacterPortrait.width(for: .big) * 1.5)
            MenuVSeparator().padding([.top, .bottom])
            VStack(alignment: .center) {
                if !skills.isEmpty {
                    Text(Localized.string("Stats"))
                        .styled(.Design.Menu.h3)
                    HStack(spacing: 32) {
                        VStack(spacing: 0) {
                            HStack {
                                Image("health")
                                    .foregroundColor(Color(.Design.Content.main))
                                Text(Localized.number(stats.health))
                                    .styled(.Design.Menu.h1)
                            }
                            HStack {
                                Image("mind")
                                    .foregroundColor(Color(.Design.Content.main))
                                Text(Localized.number(stats.mind))
                                    .styled(.Design.Menu.h1)
                            }
                        }
                        .padding(
                            EdgeInsets(
                                top: 8,
                                leading: 16,
                                bottom: 8,
                                trailing: 24
                            )
                        )
                        .border(Color(.Design.Content.main))

                        HStack(alignment: .bottom, spacing: 8) {
                            ForEach(skills, id: \.icon) { skill in
                                VStack(alignment: .center, spacing: 0) {
                                    Image(skill.icon)
                                        .foregroundColor(Color(.Design.Content.main))
                                    Text(Localized.number(skill.value))
                                        .styled(.Design.Menu.h1)
                                }
                            }
                            Text("+ 2")
                                .styled(.Design.Menu.h1)
                                .padding(.leading)
                        }
                        .padding()
                        .border(Color(.Design.Content.main))
                    }
                }
                UnderConstructionView(textStyle: .Design.Menu.debug)
                MenuButton(title: Localized.string("Add"), icons: .rightIcon("arrow.up.right"))
            }
        }
    }
}

struct ConfigureCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureCharacterView.mock()
        .padding(32)
        .background(Color(.Design.Background.main))
        .ignoresSafeArea()
    }
}
