import UserNotifications

final class UserNotificationManager {
    
    static let shared = UserNotificationManager()
    
    private init() {}
    
    func registerLocalNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("User did not give logged in")
            }
        }
    }
    
    func scheduleLocalNotification(withTitle title: String, andDate date: Date) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Rest time"
        content.body = "It's time to watch a movie - \(title)"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        let decomposedDate = date.getDayMonthYearAndHour()
        dateComponents.hour = decomposedDate.hour
        dateComponents.minute = decomposedDate.minute
        dateComponents.month = decomposedDate.month
        dateComponents.year = decomposedDate.year
        dateComponents.day = decomposedDate.day
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
