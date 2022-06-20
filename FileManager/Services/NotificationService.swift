//
//  NotificationService.swift
//  FileManager
//
//  Created by Екатерина Неделько on 17.06.22.
//

import UserNotifications

class NotificationService {
    
    // MARK: - Public Properties
    
    static let shared = NotificationService()
    
    // MARK: - Private Properties
    
    private let center = UNUserNotificationCenter.current()
    
    // MARK: - Initialization
    
    private init() { }
    
    func requestNotificationsPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.sendLocalEverydayNotification()
            }
        }
    }
    
    // MARK: - Notification methods
    
    func sendLocalAfterClosingNotification() {
        let interval = 600
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval),
                                                        repeats: true)
        
        createNotification(title: "File manager", body: "Сome back sooner!", trigger: trigger, id: "afterClosingNotificationID")
    }
    
    private func sendLocalEverydayNotification() {
        var dateComponents = DateComponents()
        dateComponents.hour = 10
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        createNotification(title: "Good morning", body: "Don't forget to add new files!", trigger: trigger, id: "EverydayNotificationID")
    }
    
    private func createNotification(title: String, body: String, trigger: UNNotificationTrigger, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let request = UNNotificationRequest(identifier: id,
                                            content: content,
                                            trigger: trigger)

        center.add(request) { error in
            if error != nil {
              print("Error")
            }
        }
    }
}
