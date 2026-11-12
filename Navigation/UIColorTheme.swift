//
//  UIColorTheme.swift
//  Navigation
//
//  Created by Mysty Mystylal on 09.11.2026.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
    static let appBackground: UIColor = .createColor(lightMode: .white, darkMode: .black)
    static let appText: UIColor = .createColor(lightMode: .black, darkMode: .white)
    static let appSecondaryText: UIColor = .createColor(lightMode: .gray, darkMode: .lightGray)
    static let appSecondaryBackground: UIColor = .createColor(lightMode: .systemGray6, darkMode: .darkGray)
    
}

