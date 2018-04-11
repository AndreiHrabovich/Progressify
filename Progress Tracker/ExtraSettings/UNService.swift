//
//  UNService.swift
//  PushNotificationsTest
//
//  Created by Andrei on 3/24/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    private override init() {}
    static let shared = UNService()
    fileprivate let unCenter = UNUserNotificationCenter.current()
    //900 seconds = 15 minutes or 1800 seconds = 30 minutes
    fileprivate let requestTime: TimeInterval = 1800
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .sound, .carPlay ]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            guard granted else { return }
        }
        self.configure()
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
    fileprivate func requestTimer(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.body = notificationBody
        content.sound = .default()

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        unCenter.add(request)
    }

    func triggerNotifications() {
        unCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized  {
                UNService.shared.requestTimer(with: self.requestTime)
            }
        }
    }

    func removeNotifications() {
        unCenter.removeAllPendingNotificationRequests()
    }
    
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}

