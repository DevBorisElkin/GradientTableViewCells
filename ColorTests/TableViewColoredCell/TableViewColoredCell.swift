//
//  TableViewColoredCell.swift
//  ColorTests
//
//  Created by test on 08.08.2022.
//

import UIKit

class TableViewColoredCell: UITableViewCell {

    static let reuseId = "coloredCell"
    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var gradientView: GradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    private func initUI(){
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 5, height: 10)
        
        gradientView.layer.cornerRadius = 20
        gradientView.layer.masksToBounds = true
    }
    
    func setUpColors(topColor: UIColor, bottomColor: UIColor){
        gradientView.setColors(startColor: topColor, endColor: bottomColor)
    }
}
