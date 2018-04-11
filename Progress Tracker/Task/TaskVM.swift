//
//  TaskVM.swift
//  Progress Tracker
//
//  Created by Andrei on 2/22/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class TaskVM {
    
    //MARK: - properties
    
    let db = DisposeBag()
    var task = Task(name: "Dummy Task", sessions: List())
    
    //MARK: - methods
    
    func createNewSessionVC() -> SessionVC {
        let sessionVC = SessionVC()
        sessionVC.sessionVM.observedTime
            .subscribe(onNext: { [unowned self] newSessionTime in
                try! self.task.realm?.write {
                    self.task.sessions.append(newSessionTime)
                }
            }).disposed(by: db)
        return sessionVC
    }
}
