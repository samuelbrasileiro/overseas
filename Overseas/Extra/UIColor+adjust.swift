//
//  UIColor+adjust.swift
//  Overseas
//
//  Created by Samuel Brasileiro on 19/07/21.
//

import SwiftUI

extension Color{
    static let lightBlue = Color(red: 0x6d/0xff, green: 0x7a/0xff, blue: 0xed/0xff, opacity: 1)
    static let darkBlue = Color(red: 0x35/0xff, green: 0x46/0xff, blue: 0xe6/0xff, opacity: 1)
}

extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
