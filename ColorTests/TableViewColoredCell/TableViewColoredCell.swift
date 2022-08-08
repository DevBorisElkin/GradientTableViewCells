//
//  TableViewColoredCell.swift
//  ColorTests
//
//  Created by test on 08.08.2022.
//

import UIKit

class TableViewColoredCell: UITableViewCell {

    static let reuseId = "coloredCell"
    var useGradient: Bool = false
    
    lazy var cardView: UIView = {
        var view = UIView()
        print("created cardView")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 5, height: 10)
        return view
    }()
    lazy var colorView: UIView = {
        var view = UIView()
        print("created colorView")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    lazy var gradientView: GradientView = {
        var view = GradientView()
        print("created gradientView")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI(useGradient: Constants.useGradientForCells)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(useGradient: Bool){
        print(#function + " useGradient: \(useGradient)")
        self.useGradient = useGradient
        
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardViewInsets)
        
        if(!useGradient){
            cardView.addSubview(colorView)
            colorView.fillSuperview(padding: Constants.cardViewInsets)
        }else{
            cardView.addSubview(gradientView)
            gradientView.fillSuperview(padding: Constants.cardViewInsets)
        }
    }
    
    func setUpColor(color: UIColor){
        guard !useGradient else { fatalError(); return }
        colorView.backgroundColor = color
    }
    
    func setUpColors(topColor: UIColor, bottomColor: UIColor){
        guard useGradient else { fatalError(); return }
        gradientView.setColors(startColor: topColor, endColor: bottomColor)
    }
}
