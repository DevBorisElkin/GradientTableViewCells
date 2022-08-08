//
//  ViewController.swift
//  ColorTests
//
//  Created by test on 08.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var colorCalculator = ColorCalculator(initialColor: Constants.initialColor, colorStepPerUnit: Constants.colorStepPerUnit)
    
    var cells: [Cell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp(){
        cells = []
        var cumulativeHeight: CGFloat = 0
        for i in 0..<Constants.numberOfCells{
            let randomHeight = Double.random(in:  Constants.minMaxRandomHeight.minHeight...Constants.minMaxRandomHeight.maxHeight)
            
            let color = colorCalculator.calculateColor(elementIndex: i)!
            
            let colors = colorCalculator.calculateColor(elementTopPoint: cumulativeHeight, elementBottomPoint: cumulativeHeight + randomHeight)
            
            cells.append(Cell(height: randomHeight, colorCalculation: colors, color: color))
            cumulativeHeight += randomHeight
        }
        
        cells.forEach { cell in
            cell.colorCalculation.topColor.printColorHSB()
        }
        
        tableView.register(TableViewColoredCell.self, forCellReuseIdentifier: TableViewColoredCell.reuseId)
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewColoredCell.reuseId) as! TableViewColoredCell
        
        let cellObj = cells[indexPath.row]
        
        if(Constants.useGradientForCells){
            cell.setUpColors(topColor: cellObj.colorCalculation.topColor, bottomColor: cellObj.colorCalculation.bottomColor)
        }else{
            cell.setUpColor(color: cellObj.color)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height
    }
}

struct Cell {
    var height: CGFloat
    var colorCalculation: ColorCalculation!
    var color: UIColor
}

