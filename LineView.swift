//
//  lineView.swift
//  Social
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 Paladin-engineering. All rights reserved.
//

import Foundation

extension String {
    var color: UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.black
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

/** View that have line with 1px on the top */
class LineView :UIView {

    @IBInspectable open var color : UIColor = "C8C7CC".color
    @IBInspectable open var yPosition: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setShouldAntialias(false)
        context!.setLineWidth(1)
        context!.setStrokeColor(color.cgColor)
        context!.move(to: CGPoint(x: 0, y: yPosition))
        let width = self.bounds.width
        context!.addLine(to: CGPoint(x: width, y: yPosition))
        context!.strokePath()
    }
}
