//
//  Task.swift
//  Progress Tracker
//
//  Created by Andrei on 2/22/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class Task: Object {
    
    @objc dynamic var name: String = ""
    var sessions = List<Int>()
    
    var progressTime: String {
        let totalTime = sessions.reduce(0) { (res, next) -> Int in
            return res + next
        }
        let hours = totalTime / 3600
        let minutes = (totalTime % 3600) / 60
        let seconds = (totalTime % 3600) % 60
        return "\(hours) " + hoursText + " \(minutes) " + minutesText + " \(seconds) " + secondsText
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(name: String, sessions: List<Int>) {
        self.init()
        self.name = name
        self.sessions = sessions
    }
}



