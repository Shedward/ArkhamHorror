//
//  ConfigureCharacterView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI
import Prelude
import DesignSystem

struct ConfigureCharacterView: View {

    @Environment(\.menuNavigator)
    var menuNavigator: MenuNavigator
    @Environment(\.design)
    var design: DesignSystem

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
                characterSection
                    .padding(.bottom)
                storySection
                rolesSection
            }
            .frame(maxWidth: CharacterPortrait.width(for: .big) * 1.5)
            MenuVSeparator().padding([.top, .bottom])
            VStack(alignment: .center) {
                statsSection
                UnderConstructionView(textKind: \.menu.debug)
                buttonsSection
            }
        }
    }

    var characterSection: some View {
        VStack {
            CharacterPortrait(size: .big)
            VStack {
                Text(name)
                    .styled(design.text.menu.h2)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Text(profession)
                    .styled(design.text.menu.story)
            }
        }
    }

    var storySection: some View {
        VStack {
            MenuHSeparator()
                .frame(maxWidth: 50)
            Text(story)
                .styled(design.text.menu.story)
        }
    }

    var rolesSection: some View {
        VStack {
            if !roles.isEmpty {
                MenuHSeparator()
                    .frame(maxWidth: 50)
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(roles, id: \.name) { role in
                        let name = Localized.string("%@ - ", arguments: role.name)
                        let formattedName = AttributedString(name)
                            .styled(design.text.menu.keyword)
                        let formattedDescription = AttributedString(role.description)
                            .styled(design.text.menu.body)
                        Text(formattedName + formattedDescription)
                    }
                }
                .padding(.top)
            }
        }
    }

    var statsSection: some View {
        VStack {
            if !skills.isEmpty {
                Text(Localized.string("Stats"))
                    .styled(design.text.menu.h3)
                HStack(spacing: 32) {
                    VStack(spacing: 0) {
                        HStack {
                            Image("health", bundle: .module)
                                .foregroundColor(design.color.content.main)
                            Text(Localized.number(stats.health))
                                .styled(design.text.menu.h1)
                        }
                        HStack {
                            Image("mind", bundle: .module)
                                .foregroundColor(Color(design.color.content.main))
                            Text(Localized.number(stats.mind))
                                .styled(design.text.menu.h1)
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
                    .border(design.color.content.main)

                    HStack(alignment: .bottom, spacing: 8) {
                        ForEach(skills, id: \.icon) { skill in
                            VStack(alignment: .center, spacing: 0) {
                                Image(skill.icon, bundle: .module)
                                    .foregroundColor(design.color.content.main)
                                Text(Localized.number(skill.value))
                                    .styled(design.text.menu.h1)
                            }
                        }
                        Text("+ 2")
                            .styled(design.text.menu.h1)
                            .padding(.leading)
                    }
                    .padding()
                    .border(design.color.content.main)
                }
            }
        }
    }

    var buttonsSection: some View {
        HStack {
            MenuButton(title: Localized.string("Back"), icons: .leftIcon("arrow.backward"))
                .onTapGesture {
                    menuNavigator.pop()
                }
            Spacer()
            MenuButton(title: Localized.string("Add"), icons: .rightIcon("arrow.up.right"))
        }
        .padding([.leading, .trailing], 128)
    }
}

struct ConfigureCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPreview {
            ConfigureCharacterView.mock()
        }
    }
}
