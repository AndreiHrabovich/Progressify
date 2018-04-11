//
//  TaskListVM.swift
//  Progress Tracker
//
//  Created by Andrei on 2/25/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class TaskListVM {
    
    //MARK: - properties
    
    var tasks = Variable<[Task]>([])
    let db = DisposeBag()
    let realm = try! Realm()
    
    //MARK: - methods
    
    func populateTableView() {
        tasks.value = realm.objects(Task.self).map { return $0 as Task }
    }
    
    func goToSelectedTask(selectedTask: Task) -> TaskVC {
        let taskVC = TaskVC()
        taskVC.taskVM.task = selectedTask
        return taskVC
    }
    
    func createNewTask(forVC vc: UIViewController , withName newName: String) {
        let containsDuplicate = checkForDuplicateNames(against: newName)
        containsDuplicate ? showAlert(vc: vc): addNewTask(taskName: newName)
    }
    
    fileprivate func addNewTask(taskName: String) {
        let newTask = Task(name: taskName, sessions: List())
        tasks.value.append(newTask)
        try! realm.write {
            realm.add(newTask, update: true)
        }
    }
    
    fileprivate func showAlert(vc: UIViewController) {
        let duplicateNameAlert = UIAlertController(title: duplicateNameAlertTitleText, message: duplicateNameAlertMessageText, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        duplicateNameAlert.addAction(ok)
        vc.present(duplicateNameAlert, animated: true, completion: nil)
    }
    
    fileprivate func checkForDuplicateNames(against taskName: String) -> Bool {
        var isDuplicate = Bool()
        for task in tasks.value {
           isDuplicate = (task.name == taskName) ? true : false
            if isDuplicate {
                break
            }
        }
        return isDuplicate
    }
    
}
