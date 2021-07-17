//
//  CreateTaskViewController+picker.swift
//  Task Magician
//
//  Created by Сергей Павленок on 17.07.2021.
//

import UIKit

extension CreateTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TaskGroup.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TaskGroup.allCases[row].rawValue
    }
}
