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
typealias UView = NSView
typealias UPoint = NSPoint
typealias USize = NSSize
typealias UFloat = CGFloat

#elseif os(iOS)
import UIKit
typealias UBezierPath = UIBezierPath
typealias UColor = UIColor
typealias UView = UIView
typealias UPoint = CGPoint
typealias USize = CGSize
typealias UFloat = Float

#endif
