//
//  AppDelegate.swift
//  JRNetwork
//
//  Created by JerryWang on 05/13/2016.
//  Copyright (c) 2016 JerryWang. All rights reserved.
//

import UIKit
//import Alamofire
import JRNetwork

infix operator ^^ { associativity right precedence 155 }

func ^^(lhs: Int, rhs: Int) -> Int {
    let l = Double(lhs)
    let r = Double(rhs)
    let p = pow(l, r)
    return Int(p)
}

struct D {
    
    private let a: Int
    
    init(a: Int) {
        self.a = a
    }
    
    mutating func next() {
        self = D(a: a+1)
    }
}

//struct URL: URLRequestCachable {
//    
//    var URLRequest: NSMutableURLRequest {
//        return NSMutableURLRequest(URL: NSURL(string: "")!)
//    }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var thing1 = "cars"
        let closure1 = { [thing1] in
            print("I love \(thing1)")
        }
        thing1 = "airplanes"
        closure1()
        
        var thing2 = "cars"
        let closure2 = {
            print("I love \(thing2)")
        }
        thing2 = "airplanes"
        closure2() // Prints "I love airplanes"
        
        let url = NSURL(string: "http://www.baidu.com/user.json?k=car")
        
        var baseURL: String {
            
            var urlString: String = ""
            if let scheme = url?.scheme {
                urlString += scheme + "://"
            }
            if let host = url?.host {
                urlString += host
            }
            return urlString
        }
        
        print("base url: \(baseURL)")
        print("related path: \(url?.path)")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

