//
//  RestingHeartRateContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI
import FirebaseFirestore

/** 安静時心拍数データの確認ページ */
struct RestingHeartRateContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var restingHeartRateModel: RestingHeartRateModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let sleepReference = Firestore.firestore().collection("sleep")
    let fmtDate: DateFormatter = DateFormat().getDate()
    let fmtHoursAndMinutes: DateFormatter = DateFormat().getHoursAndMinutes()
        
    var body: some View {
        NavigationView {
            VStack {
                Text("取得した安静時心拍数データの数: \(healthKitModel.restingHeartRateItem.count)")
                if healthKitModel.heartRateItem.count == 0 {
                    Text("安静時心拍数データなし")
                } else {
                    Button {
                        restingHeartRateModel.saveRestingHeartRates(dataSource: healthKitModel.restingHeartRateItem)
                    } label: {
                        Text("安静時心拍数データの登録")
                    }
                }
                List {
                    if healthKitModel.restingHeartRateItem.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.restingHeartRateItem ){ item in
                            HStack{
                                Text("心拍数: \(item.count)")
                                Text(fmtDate.string(from: item.datetime))
                                Text(fmtHoursAndMinutes.string(from: item.datetime))
                            }
                        }
                    }
                }
            }
            .onAppear {
                healthKitModel.getRestingHeartRateInfo(startTime: fallingAsleepTime, endTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.restingHeartRateItem.removeAll()
                }
            }
        }
    }
}

