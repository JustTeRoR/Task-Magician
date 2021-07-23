//
//  TaskUnitTest.swift
//  unit_TaskMagician
//
//  Created by Сергей Павленок on 22.07.2021.
//

import XCTest
@testable import Task_Magician

class TaskUnitTests: XCTestCase {

    func testEncodingAndDecoding() {
        var indexForLoop = 0
        let testTask = Task(name: "Buy some bread", status: TaskStatus.Open,
                            group: TaskGroup.Shopping, description: "testDescription",
                            owner: "testOwner", deadline: Date())
        let arrayOfTestSubtaskNames = ["Subtask#1", "Subtask#2", "Subtask#3"]
        for subtaskName in arrayOfTestSubtaskNames {
            testTask.listOfSubtasks.append(Subtask(name: subtaskName, owner: "testOwner"))
        }
        
        let pathToFile = testTask.exportToURL()
        let decodedTestTask = Task.importData(from: pathToFile!) ?? Task()
        
        // Comparing all fields
        XCTAssert(decodedTestTask.name == testTask.name && decodedTestTask.taskDescription ==         testTask.taskDescription && decodedTestTask.status == testTask.status &&
                    decodedTestTask.group == testTask.group &&
                    decodedTestTask.owner == testTask.owner &&
                    decodedTestTask.deadline == testTask.deadline)
        XCTAssertEqual(decodedTestTask.listOfSubtasks.count, testTask.listOfSubtasks.count)
        for item in decodedTestTask.listOfSubtasks {
            XCTAssertEqual(item.name, testTask.listOfSubtasks[indexForLoop].name)
            XCTAssertEqual(item.isCompleted, testTask.listOfSubtasks[indexForLoop].isCompleted)
            XCTAssertEqual(item.owner, testTask.listOfSubtasks[indexForLoop].owner)
            indexForLoop += 1
        }
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
