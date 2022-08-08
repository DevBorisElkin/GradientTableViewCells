//
//  Constants.swift
//  ColorTests
//
//  Created by test on 08.08.2022.
//

import Foundation
import UIKit

class Constants {
    /// switch between true/false to see difference. Determines whether to use a gradient for each cell or a solid color
    static let useGradientForCells = true
    
    // initial color of the first UI element
    static let initialColor = #colorLiteral(red: 0.5934002493, green: 0.9686274529, blue: 0.7139207874, alpha: 1)
    
    /// switch between true and false to choose whether hue value needs to be incremented over scroll or decremented
    static let increaseHue = true
    
    static let hueMultiplier: CGFloat = increaseHue ? 1 : -1
    
    /// Determines how much Hue we change each CGFloat height point of our view
    static let colorIterationForGradient = 0.0005
    /// Determines how much Hue we change each CGFloat depending on the view's index
    static let colorIterationForCell = 0.005
    /// overall - less zeros == quicker color iteration.
    static let colorStepPerUnit: CGFloat = useGradientForCells ? colorIterationForGradient : colorIterationForCell
    
    static let cardViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    static let numberOfCells = 500
    static let minMaxRandomHeight = (minHeight: Double(100), maxHeight: Double(350))
}
