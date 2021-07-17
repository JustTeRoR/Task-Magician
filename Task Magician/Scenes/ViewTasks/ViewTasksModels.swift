//
//  ViewTasksModels.swift
//  Task Magician
//
//  Created by Сергей Павленок on 13.07.2021.
//

import UIKit

enum ViewTasks
{
    // MARK: Use cases
    enum UserOperations {
        struct Request {
            enum RequestType {
                case getUser
            }
        }
        struct Response {
            enum ResponseType {
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
    var name: String
}
