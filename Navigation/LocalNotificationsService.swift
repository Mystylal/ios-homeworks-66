//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 23.11.2026.
//

import UserNotifications

class LocalNotificationsService: NSObject {
    
    func registerForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .alert]) { [weak self] granted, error in
            guard granted else { return }
            self?.scheduleLatestUpdatesNotification()
        }
    }
    
    func registerUpdatesCategory() {
        let openAction = UNNotificationAction(
            identifier: "openUpdatesAction",
            title: "Открыть обновления",
            options: [.foreground]
        )
        
        let category = UNNotificationCategory(
            identifier: "updates",
            actions: [openAction],
            intentIdentifiers: [],
            options: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    private func scheduleLatestUpdatesNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "VK"
        content.body = "Посмотрите последние обновления"
        content.sound = .default
        content.categoryIdentifier = "updates"

        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "latestUpdates", content: content, trigger: trigger)
        
        center.add(request)
      }
  }

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "openUpdatesAction" {
            print("Open updates")
        }
        completionHandler()
    }
}
