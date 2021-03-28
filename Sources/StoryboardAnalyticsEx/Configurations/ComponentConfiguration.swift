//
//  ComponentConfiguration.swift - UI部品構成の基底インタフェース
//  
//
//  Created by EnchantCode on 2021/03/28.
//

import Foundation

// Type-aliases for absorb type differences between AppKit and UIKit
#if os(iOS)
import UIKit
typealias __AutoResizingMask = UIView.AutoResizingMask
typealias __LayoutGuide = UILayoutGuide
#else
import AppKit
typealias __AutoResizingMask = NSView.AutoresizingMask
typealias __LayoutGuide = NSLayoutGuide
#endif

protocol ComponentConfiguration: CustomStringConvertible {
    
    // MARK: - initializers
    init?(element: Element)
    
    // MARK: - properties
    var description: String { get }
    
    var viewtype: String { get }
    
    var contentMode: String { get }
    var translatesAutoresizingMaskIntoConstraints: Bool { get }
    var id: String { get }
    
    var rect: CGRect { get }
    
    var autoresizingMask: [__AutoResizingMask]? { get }
    
    var subviews: [ComponentConfiguration]? { get }
    var viewLayoutGuide: [__LayoutGuide]? { get }
    
    var constraints: [NSLayoutConstraint]? { get }
}

enum AutoResizingMaskKey: String, CaseIterable {
    case flexibleMinX
    case widthSizable
    case flexibleMaxX
    case flexibleMinY
    case heightSizable
    case flexibleMaxY
    
    init?(value: AutoResizingMaskValue){
        self = Self.allCases[value.offset]
    }
}

enum AutoResizingMaskValue: UInt, CaseIterable {
    case flexibleMinX = 1
    case widthSizable = 2
    case flexibleMaxX = 4
    case flexibleMinY = 8
    case heightSizable = 16
    case flexibleMaxY = 32
    
    init?(key: AutoResizingMaskKey){
        self = Self.allCases[key.offset]
    }
}

extension CaseIterable where Self: Equatable {
    var offset: AllCases.Index {
        Self.allCases.firstIndex(of: self)!
    }
}
