//
//  AppDelegate.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 24.12.2022.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.course", using: nil) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            NetworkService.urlsession.invalidateAndCancel()
        }
        
        NetworkService.getNewBitcoinCourse { (course) in
            NotificationCenter.default.post(name: NSNotification.Name("bitcoin"), object: self, userInfo: ["courseBitcoin" : course])
            task.setTaskCompleted(success: true)
        }
        
        scheduleBackgroundCourseFetch()
    }
    
    func scheduleBackgroundCourseFetch() {
        let courseFetchTask = BGAppRefreshTaskRequest(identifier: "com.course")
        courseFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 3600)
        do {
            try BGTaskScheduler.shared.submit(courseFetchTask)
        } catch {
            print(error.localizedDescription)
        }
    }

}

