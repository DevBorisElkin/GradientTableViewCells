//
//  ColorCalculator.swift
//  ColorTests
//
//  Created by Boris Elkin on 08.08.2022.
//

import Foundation
import UIKit

/// Uses HSB (Hue Saturatuon Brightness) to swich the colors (since it requires less code than RGB)
/// Current version of App doesn't consider too low values for 'colorStepPerPoint'
class ColorCalculator {
    
    var initialColor: UIColor
    var colorStepPerPoint: CGFloat
    
    /**
     Does some cool things
     - parameter initialColor: Initial color at the top of first UIView
     - parameter colorStepPerUnit: colorStepPerUnit - how much color hue value should change each point size of cell, if you use gradient to smoothly change color within the cell
     */
    init(initialColor: UIColor, colorStepPerUnit: CGFloat){
        self.initialColor = initialColor
        self.colorStepPerPoint = colorStepPerUnit
    }
    
    /**
     Helper function to calculate points for next calculation of Color at top and at bottom of view
     - parameter index: index of item in the array (could be indexPath.row)
     - parameter heights: array of heights (to iterate through them and find correct height positions)
     - returns:  Sum of people
     */
    func calculateCellPoints(index: Int, heights: [CGFloat]) -> CellPointsCalculation {
        var topPoint: CGFloat = 0
        for i in 0 ..< index{
            topPoint += heights[i]
        }
        let bottomPoint: CGFloat = topPoint + heights[index]
        return CellPointsCalculation(topPoint: topPoint, bottomPoint: bottomPoint)
    }
    
    /**
     Calculates 2 colors (top, bottom) to later be used by gradient
     - parameter elementTopPoint: top point of the view
     - parameter elementBottomPoint: bottom point of the view
     - returns:  Struct that holds top and bottom color for the view, later to be used in gradient view
     */
    func calculateColor(elementTopPoint: CGFloat, elementBottomPoint: CGFloat) -> ColorCalculation? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if initialColor.getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            
            var topHue = h + colorStepPerPoint * elementTopPoint * Constants.hueMultiplier
            var bottomHue = h + colorStepPerPoint * elementBottomPoint * Constants.hueMultiplier
            
            checkAndFixNegativeHue(hue: &topHue)
            checkAndFixNegativeHue(hue: &bottomHue)
            print("topHue: \(topHue)")
            
            let startColor = UIColor(hue: topHue, saturation: s, brightness: b, alpha: 1)
            let endColor = UIColor(hue: bottomHue, saturation: s, brightness: b, alpha: 1)
            
            return ColorCalculation(topColor: startColor, bottomColor: endColor)
        } else {
            print("Failed with color space")
            return nil
        }
    }
    
    /**
     Simplified version of a function to calculate solid color of view based soley on it's index
     - parameter elementIndex: index of view
     - returns:  color for the view
     */
    func calculateColor(elementIndex: Int) -> UIColor? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if initialColor.getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            var hueValue = h + colorStepPerPoint * CGFloat(elementIndex) * Constants.hueMultiplier
            checkAndFixNegativeHue(hue: &hueValue)
            return UIColor(hue: hueValue, saturation: s, brightness: b, alpha: 1)
        } else {
            print("Failed with color space")
            return nil
        }
    }
    
    /// helper function to invert the hue
    private func checkAndFixNegativeHue(hue: inout CGFloat){
        if(hue < 0){
            hue = hue.truncatingRemainder(dividingBy: 1)
            hue = 1 + hue
        }
        print("returning hue: \(hue)")
    }
}

/**
 Helper struct that holds 2 CGFloats for view top & bottom points
 */
struct CellPointsCalculation {
    var topPoint: CGFloat
    var bottomPoint: CGFloat
}
/**
 Helper struct that holds 2 Colors - result of color calculation
 */
struct ColorCalculation {
    var topColor: UIColor
    var bottomColor: UIColor
}

// example of hue extensions
extension UIColor {
    func printColorHSB(){
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            print("Color values: h: \(h), s: \(s), b: \(b)")
        } else {
            print("Can't print color values, failed with color space")
        }
    }
    
    func getHue() -> CGFloat {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        if getHue(&h, saturation: &s, brightness: &b, alpha: nil) {
            return h
        } else {
            print("Can't print color values, failed with color space")
            return 0
        }
    }
}
