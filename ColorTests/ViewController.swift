//
//  ViewController.swift
//  ColorTests
//
//  Created by test on 08.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var colorCalculator = ColorCalculator(initialColor: #colorLiteral(red: 0.6443478301, green: 0.4843137264, blue: 0.9686274529, alpha: 1), colorStepPerUnit: 0.000005)
    var cells: [Cell]!
    var minMaxRandomHeight = (minHeight: Double(100), maxHeight: Double(300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp(){
        cells = []
        var cumulativeHeight: CGFloat = 0
        for i in 0..<500{
            var randomHeight = Double.random(in: minMaxRandomHeight.minHeight...minMaxRandomHeight.maxHeight)
            var colors = colorCalculator.calculateColor(elementTopPoint: cumulativeHeight, elementBottomPoint: cumulativeHeight + randomHeight)

            cells.append(Cell(height: randomHeight, colorCalculation: colors))
            cumulativeHeight += randomHeight
        }
        
        tableView.register(UINib(nibName: "TableViewColoredCell", bundle: nil), forCellReuseIdentifier: TableViewColoredCell.reuseId)
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableViewColoredCell.reuseId) as! TableViewColoredCell
        
        var cellObj = cells[indexPath.row]
        
        cell.setUpColors(topColor: cellObj.colorCalculation.topColor, bottomColor: cellObj.colorCalculation.bottomColor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height
    }
}

struct Cell {
    var height: CGFloat
    var colorCalculation: ColorCalculation!
}

