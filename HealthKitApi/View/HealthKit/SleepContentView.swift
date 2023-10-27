//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/18.
//

import SwiftUI
import FirebaseFirestore

// 睡眠データの確認ページ
struct SleepContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var sleepModel: SleepModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let sleepReference = Firestore.firestore().collection("sleep")
    
    let fmtDate: DateFormatter = DateFormat().getDate()
    let fmtHoursAndMinutes: DateFormatter = DateFormat().getHoursAndMinutes()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("取得した睡眠データの数: \(healthKitModel.sleepItem.count)")
                if healthKitModel.sleepItem.count == 0 {
                    Text("睡眠データなし")
                } else {
                    Button {
                        sleepModel.saveSleeps(dataSource: healthKitModel.sleepItem)
                    } label: {
                        Text("睡眠データの登録")
                    }
                }
                List {
                    if healthKitModel.sleepItem.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.sleepItem ){ item in
                            HStack{
                                if item.sleepStatus == "0" {
                                    Text("就寝時間")
                                } else if item.sleepStatus == "1" {
                                    Text("睡眠時間")
                                } else if item.sleepStatus == "2" {
                                    Text("覚醒")
                                } else if item.sleepStatus == "3" {
                                    Text("コア")
                                } else if item.sleepStatus == "4" {
                                    Text("深い睡眠")
                                } else if item.sleepStatus == "5" {
                                    Text("レム")
                                } else {
                                    Text("その他(sleepStatusが0~5以外)")
                                }
                                Text(fmtDate.string(from: item.startDateTime))
                                Text(fmtHoursAndMinutes.string(from: item.startDateTime) + " ~ " + fmtHoursAndMinutes.string(from: item.endDateTime))
                            }
                        }
                    }
                }
            }
            // ページ読み込み時にデータを新しくする
            .onAppear {
                healthKitModel.getSleepAnalysis(fallingAsleepTime: fallingAsleepTime, wakeUpTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.sleepItem.removeAll()
                }
            }
        }
    }
}
