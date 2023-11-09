//
//  ActivityEnergyBurnedView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI
import FirebaseFirestore

/** アクティブエネルギーデータの確認ページ */
struct ActivityEnergyBurnedView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var activityEnergyBurnedModel: ActivityEnergyBurnedModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let fmtDate: DateFormatter = DateFormat().getDate()
    let fmtHoursAndMinutes: DateFormatter = DateFormat().getHoursAndMinutes()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("取得したアクティブエネルギーデータの数: \(healthKitModel.activeEnergyBurnedItem.count)")
                if healthKitModel.activeEnergyBurnedItem.count == 0 {
                    Text("アクティブエネルギーデータなし")
                } else {
                    Button {
                        activityEnergyBurnedModel.saveActivityEnergyBurneds(dataSource: healthKitModel.activeEnergyBurnedItem)
                    } label: {
                        Text("アクティブエネルギーデータの登録")
                    }
                }
                List {
                    if healthKitModel.activeEnergyBurnedItem.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.activeEnergyBurnedItem ){ item in
                            HStack{
                                Text("消費カロリー: \(String(format: "%.2f", item.kcal))")
                                Text(fmtDate.string(from: item.startDateTime))
                                Text(fmtHoursAndMinutes.string(from: item.startDateTime) + " ~ " + fmtHoursAndMinutes.string(from: item.endDateTime))
                            }
                        }
                    }
                }
            }
            // ページ読み込み時にデータを新しくする
            .onAppear {
                healthKitModel.getActiveEnergyBurned(startTime: fallingAsleepTime, endTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.activeEnergyBurnedItem.removeAll()
                }
            }
        }
    }
}
