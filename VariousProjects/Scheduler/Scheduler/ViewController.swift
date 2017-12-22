//
//  ViewController.swift
//  Scheduler
//
//  Created by Matt Baker on 1/28/16.
//  Copyright © 2016 Matt Baker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var infoField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    var tableData = [[String]] (repeating: [], count: 7)
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addInfoClick(_ sender: UIButton) {
        //currRow gives us the day
        let currRow = pickerView.selectedRow(inComponent: 0)
		guard let myText = infoField.text
			else {
				tableData[currRow].append("hi")
				return
		}
		infoField.text! = ""
        tableData[currRow].append(myText)
        myTableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
		UIView.animate(withDuration: 0.25, animations: {
			cell.layer.transform = CATransform3DMakeScale(1,1,1)
		})
        cell.textLabel?.text = tableData[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected (\(indexPath.section),\(indexPath.row))")
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
        
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
