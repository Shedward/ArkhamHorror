//
//  View+withoutAnimation.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

extension View {
    func withoutAnimation() -> some View {
        animation(nil, value: UUID())
    }
}
