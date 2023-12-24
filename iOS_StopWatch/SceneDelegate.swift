//
//  SceneDelegate.swift
//  iOS_StopWatch
//
//  Created by Yerassyl Adilkhan.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // creating VSs
        let stopwatchVC = StopwatchViewController()
        stopwatchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "stopwatch"), tag: 0)

        let timerVC = TimerViewController()
        timerVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "timer"), tag: 1)
        
        // setting VCs as tab bar items
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [stopwatchVC, timerVC]

        UITabBar.appearance().barTintColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        UITabBar.appearance().tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

