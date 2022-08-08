//
//  ColorCalculator.swift
//  ColorTests
//
//  Created by Boris Elkin on 08.08.2022.
//

import Foundation
import UIKit

class ColorCalculator {
    
    var initialColor: UIColor
    var colorStepPerPoint: CGFloat
    
    /// colorStepPerUnit - how much color hue value should change each point size of cell, if you use gradient to smoothly change color within the cell
    init(initialColor: UIColor, colorStepPerUnit: CGFloat){
        self.initialColor = initialColor
        self.colorStepPerPoint = colorStepPerUnit
    }
    
    func calculateCellPoints(index: Int, heights: [CGFloat]) -> CellPointsCalculation {
        var topPoint: CGFloat = 0
        for i in 0 ..< index{
            topPoint += heights[i]
        }
        var bottomPoint: CGFloat = topPoint + heights[index]
        return CellPointsCalculation(topPoint: topPoint, bottomPoint: bottomPoint)
    }
    
    func calculateColor(elementTopPoint: CGFloat, elementBottomPoint: CGFloat) -> ColorCalculation? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if initialColor.getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            var topHue = h + colorStepPerPoint * elementTopPoint
            var bottomHue = h + colorStepPerPoint * elementBottomPoint
            //print("h: \(h), s: \(s), b: \(b)")
            var startColor = UIColor(hue: topHue, saturation: s, brightness: b, alpha: 1)
            var endColor = UIColor(hue: bottomHue, saturation: s, brightness: b, alpha: 1)
            
            return ColorCalculation(topColor: startColor, bottomColor: endColor)
        } else {
            print("Failed with color space")
            return nil
        }
    }
    
    func calculateColor(elementIndex: Int) -> UIColor? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if initialColor.getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            var colorHue = h + colorStepPerPoint * CGFloat(elementIndex)
            //print("h: \(h), s: \(s), b: \(b)")
            return UIColor(hue: colorHue, saturation: s, brightness: b, alpha: 1)
        } else {
            print("Failed with color space")
            return nil
        }
    }
}

struct CellPointsCalculation {
    var topPoint: CGFloat
    var bottomPoint: CGFloat
}

struct ColorCalculation {
    var topColor: UIColor
    var bottomColor: UIColor
}
