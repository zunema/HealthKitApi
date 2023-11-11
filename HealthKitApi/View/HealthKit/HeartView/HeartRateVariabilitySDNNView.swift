//
//  HeartRateVariabilitySDNNView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/11.
//

import SwiftUI
import FirebaseFirestore

/** 心拍変動データの確認ページ */
struct HeartRateVariabilitySDNNView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var heartRateVariabilitySDNNModel: HeartRateVariabilitySDNNModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let fmtDate: DateFormatter = DateFormat().getDate()
    let fmtHoursAndMinutes: DateFormatter = DateFormat().getHoursAndMinutes()
        
    var body: some View {
        NavigationView {
            VStack {
                Text("取得した心拍変動データの数: \(healthKitModel.heartRateVariabilitySDNNItem.count)")
                if healthKitModel.heartRateVariabilitySDNNItem.count == 0 {
                    Text("心拍変動データなし")
                } else {
                    Button {
                        heartRateVariabilitySDNNModel.saveHeartRatesVariabilitySDNN(dataSource: healthKitModel.heartRateVariabilitySDNNItem)
                    } label: {
                        Text("心拍変動データの登録")
                    }
                }
                List {
                    if healthKitModel.heartRateVariabilitySDNNItem.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.heartRateVariabilitySDNNItem ){ item in
                            HStack{
                                Text("心拍変動: \(item.count)")
                                Text(fmtDate.string(from: item.startTime))
                                Text(fmtHoursAndMinutes.string(from: item.startTime) + "~" + fmtHoursAndMinutes.string(from: item.endTime))
                            }
                        }
                    }
                }
            }
            .onAppear {
                healthKitModel.getHeartRateVariabilitySDNNInfo(startTime: fallingAsleepTime, endTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.heartRateVariabilitySDNNItem.removeAll()
                }
            }
        }
    }
}

