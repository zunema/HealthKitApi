//
//  HeartRateContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/08.
//

import SwiftUI
import FirebaseFirestore

// 心拍数データの確認ページ
struct HeartRateContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var heartRateModel: HeartRateModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let sleepReference = Firestore.firestore().collection("sleep")
    let fmtDate: DateFormatter = DateFormat().getDate()
    let fmtHoursAndMinutes: DateFormatter = DateFormat().getHoursAndMinutes()
        
    var body: some View {
        NavigationView {
            VStack {
                Text("取得した心拍数データの数: \(healthKitModel.heartRateItem.count)")
                if healthKitModel.heartRateItem.count == 0 {
                    Text("心拍数データなし")
                } else {
                    Button {
                        heartRateModel.saveHeartRates(dataSource: healthKitModel.heartRateItem)
                    } label: {
                        Text("心拍数データの登録")
                    }
                }
                List {
                    if healthKitModel.heartRateItem.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.heartRateItem ){ item in
                            HStack{
                                Text("カウント: \(item.count)")
                                Text("タイム: \(fmtDate.string(from: item.datetime))")
                            }
                        }
                    }
                }
            }
            .onAppear {
                healthKitModel.getHeartRateInfo(startTime: fallingAsleepTime, endTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.heartRateItem.removeAll()
                }
            }
        }
    }
}

