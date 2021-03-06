//
//  AppDelegate.swift
//  TestMADVPanoSwift
//
//  Created by QiuDong on 2018/9/26.
//  Copyright © 2018年 QiuDong. All rights reserved.
//

/** This is a demo for stitching JPEG images with MADVPano_Swift.framework */
import UIKit
// Import the framework:
import MADVPano_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static func testMADVPanoStitching() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        if let enumerator = FileManager.default.enumerator(atPath: documentsPath) {
            var files = [NSString]()
            for file in enumerator {
                let fileName = file as! NSString
                if (fileName.pathExtension.lowercased() == "jpg" && !fileName.lowercased.hasSuffix(".stitched.jpg")) {
                    files.append(fileName)
                }
            }
            // Enumerate in all non-stitched .jpg files under documentation directory:
            for fileName in files {
                let sourcePath = documentsPath.appending("/\(fileName as String)")
                let destPath = sourcePath.appending(".stitched.jpg")
                // Create(if not exists) a temporary path for storing LUT data files, which will be deleted after stitching:
                let tempLUTDirectory = MadvImage.makeTempLUTFolder(for: sourcePath)
                // Pass (0,0) as (destWidth,destHeight) to make stitched image exactly the same size as the original one:
                MadvImage.renderMadvJPEG(to: destPath, from: sourcePath, withLUTDir: tempLUTDirectory, destWidth:0, destHeight:0, withoutStitching:false)
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppDelegate.testMADVPanoStitching()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

