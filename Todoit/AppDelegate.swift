//
//  AppDelegate.swift
//  Todoit
//
//  Created by Paolo Bernardo on 5/08/18.
//  Copyright © 2018 Paolo Bernardo. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            let _ = try Realm()
        }catch{
            print("Error initializing new Realm")
        }
        
        return true
        
    }



    

}

