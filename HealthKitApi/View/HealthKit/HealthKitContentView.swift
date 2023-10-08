//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import Combine
import HealthKit

struct HealthKitContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel = HealthKitModel()!
    @ObservedObject var sleepModel: SleepModel = SleepModel()
    @ObservedObject var heartRateModel: HeartRateModel = HeartRateModel()
    @State private var fallingAsleepTime = Date()
    @State private var wakeUpTime = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        VStack {
            
            DatePicker(selection: $fallingAsleepTime) {
                HStack {
                    Image(systemName: "clock.badge")
                    Text("開始時刻を任意で指定")
                }
            }
            DatePicker(selection: $wakeUpTime) {
                HStack {
                    Image(systemName: "clock.badge.fill")
                    Text("終了時刻を任意で指定")
                }
            }
            if healthKitModel.permissionFlg {
                NavigationLink(destination: SleepContentView(healthKitModel: healthKitModel, sleepModel: sleepModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("夢の取得情報を確認")
                }
                NavigationLink(destination: HeartRateContentView(healthKitModel: healthKitModel, heartRateModel: heartRateModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("心拍数の取得情報を確認")
                }
            }

        }
    }
}
