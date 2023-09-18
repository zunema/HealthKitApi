//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/18.
//

import SwiftUI

struct SleepContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
        
    let fmt: DateFormatter = {
        var fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return fmt
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ここで夢の内容を表示する予定")
                Text(fmt.string(from: fallingAsleepTime))
                Text(fmt.string(from: wakeUpTime))
                Text(healthKitModel.textConfirm)
            }
        }
    }
}
