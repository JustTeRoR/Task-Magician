//
//  SubtaskTableViewCell.swift
//  Task Magician
//
//  Created by Сергей Павленок on 19.07.2021.
//

import UIKit

class SubtaskTableViewCell: UITableViewCell {

    @IBOutlet weak var comletionButton: UIButton!
    @IBOutlet weak var subtaskName: UILabel!
    var callback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func commonInit(subtaskModel: Subtask, isActiveCell: Bool) {
        subtaskName.text = subtaskModel.name
        subtaskName.numberOfLines = 3
        subtaskName.lineBreakMode = .byWordWrapping
        subtaskName.sizeToFit()
        if subtaskModel.isCompleted {
            comletionButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            comletionButton.isEnabled = false
        } else {
            comletionButton.setBackgroundImage(UIImage(systemName: "checkmark.seal"), for: .normal)
            if isActiveCell {
                comletionButton.isEnabled = true
            } else {
                comletionButton.isEnabled = false
            }
            
        }
    }
    
    @IBAction func completedButtonClicked(_ sender: Any) {
        comletionButton.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        callback?()
    }
}
