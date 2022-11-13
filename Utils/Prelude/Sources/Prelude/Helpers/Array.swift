//
//  Array.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

public extension Array where Element: Identifiable {
    subscript(id id: Element.ID) -> Element? {
        get {
            first(byId: id)
        }
        set {
            guard let index = firstIndex(where: { $0.id == id }) else { return }
            if let value = newValue {
                self[index] = value
            } else {
                remove(at: index)
            }
        }
    }

    func first(byId id: Element.ID) -> Element? {
        first { $0.id == id }
    }
}

public extension Array {
    mutating func mutatingForEach(_ action: (inout Element) -> Void) {
        self = map { value in
            var newValue = value
            action(&newValue)
            return newValue
        }
    }
}
