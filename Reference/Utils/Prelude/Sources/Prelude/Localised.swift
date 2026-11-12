//
//  Localised.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

public enum Localized {
	public static func string(_ string: String) -> String {
		string
	}

    public static func string(_ format: String, arguments: CVarArg...) -> String {
        String(format: format, arguments: arguments)
    }

    public static func number(_ int: Int) -> String {
        "\(int)"
    }
}
