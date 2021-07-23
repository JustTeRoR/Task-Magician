//
//  EditTasksTests.swift
//  unit_TaskMagician
//
//  Created by Сергей Павленок on 23.07.2021.
//

import XCTest
@testable import Task_Magician

class EditTasksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEditTaskViewController() throws {
        // App should have active VK session for this unit test. It this valid approach?
        let testTask = Task(name: "Buy some bread", status: TaskStatus.Open,
                            group: TaskGroup.Shopping, description: "testDescription",
                            owner: "testOwner", deadline: Date())
        let arrayOfTestSubtaskNames = ["Subtask#1", "Subtask#2", "Subtask#3"]
        for subtaskName in arrayOfTestSubtaskNames {
            testTask.listOfSubtasks.append(Subtask(name: subtaskName, owner: "testOwner"))
        }
        let editVC: EditTaskViewController = EditTaskViewController.loadFromStoryboard()
        editVC.taskToChange = testTask
        editVC.viewDidLoad()
        
        XCTAssert(editVC.subtasksTable.numberOfRows(inSection: 0) == 3)
        XCTAssertEqual(TaskStatus.allCases[editVC.statePicker.selectedRow(inComponent: 0)], TaskStatus.init(rawValue: testTask.status))
        XCTAssertEqual(TaskGroup.allCases[editVC.groupPicker.selectedRow(inComponent: 0)], TaskGroup.init(rawValue: testTask.group))
        XCTAssertEqual(editVC.titleInputText.text, testTask.name)
        XCTAssertEqual(editVC.descriptionInputText.text, testTask.taskDescription)
        XCTAssertEqual(editVC.datePicker.date, testTask.deadline)
        XCTAssertEqual(editVC.createSubtaskButton.isEnabled, true)
    }

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
