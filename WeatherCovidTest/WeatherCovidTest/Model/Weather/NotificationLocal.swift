//
//  NotificationLocal.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/23/21.
//

import Foundation
import UserNotifications

struct NotificationLocal {

    static let shared = NotificationLocal()
    
    private init() { }
    
    func create(title : String, body : String, time : CLong, index: Int) {
        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        // Step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // Step 3: Create the notification trigger
//        let stringDate = dateString
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
//        let date = dateFormater.date(from: stringDate)
        
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "EEEE yyyy-MM-dd HH:mm:ss"
        var timeInterval = TimeInterval()
        switch index {
        case 0:
            timeInterval = TimeInterval(time - (3600/2))
        case 1:
            timeInterval = TimeInterval(time - (3600))
        case 2:
            timeInterval = TimeInterval(time - (3600*24))
        default:
            timeInterval = TimeInterval(time - (3600/2))
        }
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
//        print(dateFormatCoordinate.string(from: date as Date))
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: (date) as Date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Step 4: Create the request
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
            print(error as Any)
        }
    }
    
    func clear() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        center.removeAllPendingNotificationRequests() // To remove all pending notifications which are not delivered yet but scheduled.
    }
}
