//
//  UIKit+AppKit.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//


#if os(macOS)
import AppKit
public typealias UBezierPath = NSBezierPath
public typealias UImage = NSImage
public typealias UColor = NSColor
public typealias UView = NSView
public typealias UPoint = NSPoint
public typealias USize = NSSize
public typealias UFloat = CGFloat
public typealias VFloat = Float
public typealias UFont = NSFont

#elseif os(iOS)
import UIKit
public typealias UBezierPath = UIBezierPath
public typealias UImage = UIImage
public typealias UColor = UIColor
public typealias UView = UIView
public typealias UPoint = CGPoint
public typealias USize = CGSize
public typealias UFloat = Float
public typealias VFloat = CGFloat
public typealias UFont = UIFont

public extension UPoint {
    init(x: UFloat, y: UFloat) {
        self.init(x: Double(x), y: Double(y))
    }
}

#endif
