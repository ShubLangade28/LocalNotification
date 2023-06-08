//
//  ViewController.swift
//  LocalNotification
//
//  Created by PHN Tech 2 on 08/06/23.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { sucsess, error in
            
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func localNotificationTapped(_ sender: Any) {
        // Content
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "first_identifier"
        content.title = "My First Notification"
        content.body = "This is first example of local notification...."
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.userInfo = ["name" : "Shubham"] // exstra msg with notification
        
        //Notification Image
        let url = Bundle.main.url(forResource: "notification", withExtension: "jpeg")
        let attactment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
        content.attachments = [attactment]
        
        // Trigger Time
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false) // Timing
        let identifier = "main_identifier"
        
        //Add request to notification center
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            guard let err = error else{return}
            print(err.localizedDescription)
        }
        
        // Notification Action
        let like = UNNotificationAction.init(identifier: "like", title: "Like", options: .foreground)
        let delete = UNNotificationAction.init(identifier: "delete", title: "Delete", options: .destructive)
        let catagory = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [like, delete], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([catagory])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else{return}
        
        if let dict = response.notification.request.content.userInfo as? [String : Any]{
            secondVC.message = dict["name"] as! String
        }
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

