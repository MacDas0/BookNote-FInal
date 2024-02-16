//
//  Colors.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 29/12/2023.
//

import SwiftUI

extension Color {
    
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
    // BLACK BROWN
//    Color(red: 16 / 255, green: 14 / 255, blue: 9 / 255)
    
    static let background = Color(hex: 0x191919)
     
    static let customDark = Color(hex: 0x191919)
    static let customLightDark = Color(hex: 0x282c2c)
}

extension UIColor {
    
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }

            return nil
        }
    
    static let customDark = UIColor(hex: "#191919ff")
    static let customLightDark = UIColor(hex: "#282c2cff")
}


//Color(red: 34 / 255, green: 32 / 255, blue: 31 / 255)
