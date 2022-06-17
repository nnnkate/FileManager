//
//  NotificationService.swift
//  FileManager
//
//  Created by Екатерина Неделько on 17.06.22.
//

import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private let center = UNUserNotificationCenter.current()
    
    private var notificationIsAllowed = false
    
    private init() { }
    
    func requestNotificationsPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] success, error in
            self?.notificationIsAllowed = success
            if success {
                self?.sendLocalEverydayNotification()
            }
        }
    }
    
    func sendLocalAfterClosingNotification() {
        let content = UNMutableNotificationContent()
        content.title = "File manager"
        content.body = "Сome back sooner!"

        let interval = 600
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval),
                                                        repeats: true)

        let request = UNNotificationRequest(identifier: "afterClosingNotificationID",
                                            content: content,
                                            trigger: trigger)

        center.add(request) { error in
            if error != nil {
              print("Error")
            }
        }
    }
    
    private func sendLocalEverydayNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Good morning"
        content.body = "Don't forget to add new files!"

        var dateComponents = DateComponents()
        dateComponents.hour = 10
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)

        let request = UNNotificationRequest(identifier: "EverydayNotificationID",
                                            content: content,
                                            trigger: trigger)

        center.add(request) { error in
            if error != nil {
              print("Error")
            }
        }
    }
}
