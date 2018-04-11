//
//  SessionVM.swift
//  Progress Tracker
//
//  Created by Andrei on 2/20/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UserNotifications

class SessionVM {
    
    //MARK: - properties
    let nc = NotificationCenter.default
    let db = DisposeBag()
    var startTime = TimeInterval()
    var elapsedTime: Int = 0
    var timer = Timer()
    var iterator: Int = 0

    let displayedTimeSubject = PublishSubject<Int>()
    var displayedTime: Observable<Int> {
        return displayedTimeSubject.asObservable()
    }

    let observedTimeSubject = PublishSubject<Int>()
    var observedTime: Observable<Int> {
        return observedTimeSubject.asObservable()
    }
    
    //MARK: - methods
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        self.iterator += 1
        displayedTimeSubject.onNext(iterator)
    }
    
    func stopOrPauseTimer() {
        timer.invalidate()
        elapsedTime = 0
    }
    
    func save() {
        observedTimeSubject.onNext(iterator)
    }

    func bindTo(displayTimeLabel: Binder<String?>) {
        displayedTime
            .subscribe(onNext: {
                let hours = $0 / 3600
                let minutes = ($0 % 3600) / 60
                let seconds = ($0 % 3600) % 60
                let display = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
                displayTimeLabel.onNext(display)
            })
            .disposed(by: db)
    }
    
    @objc fileprivate func setupBackgroundTimeCounter() {
        if timer.isValid {
            startTime = Date().timeIntervalSinceReferenceDate
            elapsedTime = 0
        }
    }

    @objc fileprivate func showTimeDifference() {
        //removing notifications when the app goes active again - no need in those notifications
        UNService.shared.removeNotifications()
        
        if elapsedTime == 0 {
            if timer.isValid {
                elapsedTime = Int(Date.timeIntervalSinceReferenceDate - startTime)
                iterator += elapsedTime
            }
        } else {
            print("The method has been triggered for the SECOND time, so the iterator has NOT been updated with elapsedTime for the second time to avoid doubling the time interval!")
        }
    }
    
    @objc fileprivate func getReadyToGoBackground() {
        //trigger notifications upon entering bg (they start acting as soon as the app goes bg) but observe for app termination to remove them
        UNService.shared.triggerNotifications()
        observeForAppTermination()
    }
    
    @objc fileprivate func deleteAllNotifications() {
        UNService.shared.removeNotifications()
    }
    
    func observeForAppTermination() {
        nc.addObserver(self, selector: #selector(deleteAllNotifications), name: .UIApplicationWillTerminate, object: nil)
    }
    
    func setupNotificationCenter() {
        nc.addObserver(self, selector: #selector(setupBackgroundTimeCounter), name: .UIApplicationDidEnterBackground, object: nil)
        nc.addObserver(self, selector: #selector(showTimeDifference), name: .UIApplicationWillEnterForeground, object: nil)
        nc.addObserver(self, selector: #selector(getReadyToGoBackground), name: .UIApplicationWillResignActive, object: nil)
    }
    
    func newSessionAlert(vc: UIViewController) {        
        let alert = UIAlertController(title: newSessionAlertTitle, message: newSessionAlertBody, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
}
