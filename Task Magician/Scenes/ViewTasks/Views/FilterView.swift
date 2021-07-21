//
//  FilterView.swift
//  Task Magician
//
//  Created by Сергей Павленок on 18.07.2021.
//

import Foundation
import UIKit

class FilterView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var isFilteringActive = false
    var activeFilterCriterias: [String?] = [ nil, nil, nil ]
    var filteringStart: (([String?]) -> Void)?
    var filteringEnd: (() -> Void)?
    
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var statusGroupLabel: UILabel!
    @IBOutlet weak var taskGroupLabel: UILabel!
    @IBOutlet weak var dateGroupLabel: UILabel!
    @IBOutlet weak var openStatusBtn: RadioButton!
    @IBOutlet weak var inProgressStatusBtn: RadioButton!
    @IBOutlet weak var onHoldStatusBtn: RadioButton!
    @IBOutlet weak var completedStatusBtn: RadioButton!
    @IBOutlet weak var privateGroupBtn: RadioButton!
    @IBOutlet weak var workGroupBtn: RadioButton!
    @IBOutlet weak var shoppingGroupBtn: RadioButton!
    @IBOutlet weak var assignmentGroupBtn: RadioButton!
    @IBOutlet weak var outdatedBtn: RadioButton!
    @IBOutlet weak var toTodayBtn: RadioButton!
    @IBOutlet weak var toTomorrowBtn: RadioButton!
    @IBOutlet weak var resetAllFiltersButton: UIButton!
    @IBOutlet weak var submitSelectedFiltersButton: UIButton!
    
    var statusButtonsGroup = [RadioButton]()
    var taskGroupButtonsGroup = [RadioButton]()
    var dateButtonsGroup = [RadioButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemOrange
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setupUI()
    }

    func setupUI() {
        filterTitleLabel.text = "Фильтры"
        filterTitleLabel.textColor = UIColor.white
        statusGroupLabel.text = "По статусу задачи:"
        statusGroupLabel.textColor = UIColor.white
        taskGroupLabel.text = "По группе задачи:"
        taskGroupLabel.textColor = UIColor.white
        dateGroupLabel.text = "По дате:"
        dateGroupLabel.textColor = UIColor.white
        openStatusBtn.setTitle(TaskStatus.Open.rawValue, for: .normal)
        inProgressStatusBtn.setTitle(TaskStatus.InProgress.rawValue, for: .normal)
        onHoldStatusBtn.setTitle(TaskStatus.OnHold.rawValue, for: .normal)
        completedStatusBtn.setTitle(TaskStatus.Completed.rawValue, for: .normal)
        privateGroupBtn.setTitle(TaskGroup.Private.rawValue, for: .normal)
        workGroupBtn.setTitle(TaskGroup.Work.rawValue, for: .normal)
        shoppingGroupBtn.setTitle(TaskGroup.Shopping.rawValue, for: .normal)
        assignmentGroupBtn.setTitle(TaskGroup.Assignments.rawValue, for: .normal)
        outdatedBtn.setTitle("Истекшие", for: .normal)
        toTodayBtn.setTitle("До сегодня", for: .normal)
        toTomorrowBtn.setTitle("До завтра", for: .normal)
        submitSelectedFiltersButton.backgroundColor = UIColor.systemGreen
        submitSelectedFiltersButton.layer.borderWidth = 1
        submitSelectedFiltersButton.setTitle("Применить фильтры", for: .normal)
        submitSelectedFiltersButton.setTitleColor(UIColor.white, for: .normal)
        submitSelectedFiltersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        resetAllFiltersButton.backgroundColor = UIColor.systemRed
        resetAllFiltersButton.layer.borderWidth = 1
        resetAllFiltersButton.setTitle("Cбросить фильтры", for: .normal)
        resetAllFiltersButton.setTitleColor(UIColor.white, for: .normal)
        resetAllFiltersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        statusButtonsGroup = [openStatusBtn!, inProgressStatusBtn!, onHoldStatusBtn!, completedStatusBtn!]
        openStatusBtn?.alternateButton = [inProgressStatusBtn!, onHoldStatusBtn!, completedStatusBtn!]
        inProgressStatusBtn?.alternateButton = [openStatusBtn!, onHoldStatusBtn!, completedStatusBtn!]
        onHoldStatusBtn?.alternateButton = [openStatusBtn!, inProgressStatusBtn!, completedStatusBtn!]
        completedStatusBtn?.alternateButton = [openStatusBtn!, inProgressStatusBtn!, onHoldStatusBtn!]
        
        taskGroupButtonsGroup = [privateGroupBtn!, workGroupBtn!, shoppingGroupBtn!, assignmentGroupBtn!]
        privateGroupBtn?.alternateButton = [workGroupBtn!, shoppingGroupBtn!, assignmentGroupBtn!]
        workGroupBtn?.alternateButton = [privateGroupBtn!, shoppingGroupBtn!, assignmentGroupBtn!]
        shoppingGroupBtn?.alternateButton = [privateGroupBtn!, workGroupBtn!, assignmentGroupBtn!]
        assignmentGroupBtn?.alternateButton = [privateGroupBtn!, workGroupBtn!, shoppingGroupBtn!]
        
        dateButtonsGroup = [outdatedBtn!, toTodayBtn!, toTomorrowBtn!]
        outdatedBtn?.alternateButton = [toTodayBtn!, toTomorrowBtn!]
        toTodayBtn?.alternateButton = [outdatedBtn!, toTomorrowBtn!]
        toTomorrowBtn?.alternateButton = [outdatedBtn!, toTodayBtn!]
        
        if activeFilterCriterias.count != 0 {
            if activeFilterCriterias[0] != nil {
                for button in statusButtonsGroup {
                    if button.title(for: .normal) == activeFilterCriterias[0] {
                        button.isSelected = true
                    }
                }
            }
            if activeFilterCriterias[1] != nil {
                for button in taskGroupButtonsGroup {
                    if button.title(for: .normal) == activeFilterCriterias[1] {
                        button.isSelected = true
                    }
                }
            }
            if activeFilterCriterias[2] != nil {
                for button in dateButtonsGroup {
                    if button.title(for: .normal) == activeFilterCriterias[2] {
                        button.isSelected = true
                    }
                }
            }
        }
    }
    @IBAction func resetAllbtnClicked(_ sender: Any) {
        isFilteringActive = false
        filteringEnd?()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func subitAllBtnClicked(_ sender: Any) {
        isFilteringActive = true
        collectSelectedCriteria()
        filteringStart?(activeFilterCriterias)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    func collectSelectedCriteria() {
        activeFilterCriterias = [nil, nil, nil]
        for button in statusButtonsGroup {
            if button.isSelected == true {
                activeFilterCriterias[0] = button.title(for: .normal)
            }
        }
        for button in taskGroupButtonsGroup {
            if button.isSelected == true {
                activeFilterCriterias[1] = button.title(for: .normal)
            }
        }
        
        for button in dateButtonsGroup {
            if button.isSelected == true  {
                activeFilterCriterias[2] = button.title(for: .normal)
            }
        }
        
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
