//
//  AppDelegate.swift
//  BitStreamCodableDev
//
//  Created by Michal Fousek on 10.05.2021.
//

import UIKit
import BitStreamCodableDevFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let decoder = try! JSONDecoder().decode(Array<Int>.self, from: Data())

//        let sourceData = "Loren ipsum".data(using: .utf8)!
//        let sourceData: Array<Int> = [21, 22, 23]
//        let sourceData: Array<Int?> = [21, 22, 23, nil, 15]
        let sourceData: [String: Int] = ["hello": 5, "world": 5, "whatever": 8]
//        let sourceData = "H".data(using: .utf8)!
//        let sourceData = MyData(value: 221, asset: Asset(assetID: 999))
//        let sourceData = -10
//        let sourceData: Int8 = -10
//        let sourceData: Int? = nil
//        let sourceData = "Hello world"
//
        let bitStream = BitStream()

        let encoded = bitStream.encode(sourceData)
        dump(encoded)
//        let decodedRaw = try! bitStream.decode(Array<Int>.self, from: encoded)
        let decodedRaw = try! bitStream.decode(Dictionary<String, Int>.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Data.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Int.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(MyData.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Int8.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Int?.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Array<Int?>.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(String.self, from: encoded)

        dump(decodedRaw)

//        let str = String(data: decodedRaw, encoding: .utf8)
//        print(str)

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


}

