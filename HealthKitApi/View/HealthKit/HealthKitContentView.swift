//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import Combine
import HealthKit

/** このViewで各ヘルスデータへアクセスする */
struct HealthKitContentView: View {
    
    @ObservedObject var healthKitModel = HealthKitModel()!
    @ObservedObject var sleepModel = SleepModel()
    @ObservedObject var heartRateModel = HeartRateModel()
    @ObservedObject var restingHeartRateModel = RestingHeartRateModel()
    @ObservedObject var heartRateVariabilitySDNNModel = HeartRateVariabilitySDNNModel()
    @ObservedObject var activityEnergyBurnedModel = ActivityEnergyBurnedModel()
    @State private var fallingAsleepTime = Date()
    @State private var wakeUpTime = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        VStack {
            
            DatePicker(selection: $fallingAsleepTime) {
                HStack {
                    Image(systemName: "clock.badge")
                    Text("開始時刻を指定")
                }
            }
            DatePicker(selection: $wakeUpTime) {
                HStack {
                    Image(systemName: "clock.badge.fill")
                    Text("終了時刻を指定")
                }
            }
            if healthKitModel.permissionFlg {
                NavigationLink(destination: SleepContentView(healthKitModel: healthKitModel, sleepModel: sleepModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("夢の取得情報を確認")
                }
                NavigationLink(destination: HeartRateContentView(healthKitModel: healthKitModel, heartRateModel: heartRateModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("心拍数の取得情報を確認")
                }
                NavigationLink(destination: RestingHeartRateContentView(healthKitModel: healthKitModel, restingHeartRateModel: restingHeartRateModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("安静時心拍数の取得情報を確認")
                }
                NavigationLink(destination: HeartRateVariabilitySDNNView(healthKitModel: healthKitModel, heartRateVariabilitySDNNModel: heartRateVariabilitySDNNModel , fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("心拍変動の取得情報を確認")
                }
                NavigationLink(destination: ActivityEnergyBurnedView(healthKitModel: healthKitModel, activityEnergyBurnedModel: activityEnergyBurnedModel, fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("アクティブエネルギーの取得情報を確認")
                }
            }

        }
    }
}
