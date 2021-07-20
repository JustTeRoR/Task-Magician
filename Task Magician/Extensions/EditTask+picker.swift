//
//  EditTask+picker.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import UIKit

extension EditTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return TaskGroup.allCases.count
        } else {
            return TaskStatus.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return TaskGroup.allCases[row].rawValue
        } else {
            return TaskStatus.allCases[row].rawValue
        }
    }
}
