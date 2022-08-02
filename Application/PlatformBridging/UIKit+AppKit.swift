//
//  UIKit+AppKit.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 02.08.2022.
//


#if os(macOS)
import AppKit
typealias UBezierPath = NSBezierPath
typealias UColor = NSColor

#elseif os(iOS)
import UIKit
typealias UBezierPath = UIBezierPath
typealias UColor = UIColor

#endif
