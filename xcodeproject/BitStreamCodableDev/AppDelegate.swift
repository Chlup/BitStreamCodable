/*
 MIT License

 Copyright (c) 2021 Michal Fousek

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import BitStreamCodableDevFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let decoder = try! JSONDecoder().decode(Array<Int>.self, from: Data())

//        let sourceData: UInt16 = 333
//        let sourceData = "Loren ipsum".data(using: .utf8)!
//        let sourceData: Array<Int> = [21, 22, 23]
//        let sourceData: Array<Int?> = [21, 22, 23, nil, 15]
//        let sourceData: [String: Int] = ["hello": 5, "world": 5, "whatever": 8]
//        let sourceData = "H".data(using: .utf8)!
        let sourceData = MyData(value: 221, asset: Asset(assetID: 999))
//        let sourceData = 200
//        let sourceData: Int8 = -10
//        let sourceData: Int? = nil
//        let sourceData = "Hello world"
//        let sourceData: Float = 3.14159
//        let sourceData: Float80 = 3.14159
//        let sourceData: Double = 3.14159
//        let sourceData: Bool = false
//        let sourceData: Date = Date()

        print("Source")
        dump(sourceData)

        let bitStream = BitStream()

        let encoded = bitStream.encode(sourceData)
        dump(encoded)

//        let decodedRaw = try! bitStream.decode(Array<Int>.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Dictionary<String, Int>.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Data.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(UInt16.self, from: encoded)
        let decodedRaw = try! bitStream.decode(MyData.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Int8.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Int?.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Array<Int?>.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(String.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Float.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Double.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Float80.self, from: encoded)
//        let decodedRaw = try! bitStream.decode(Date.self, from: encoded)

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

