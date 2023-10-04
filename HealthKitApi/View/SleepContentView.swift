//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/18.
//

import SwiftUI
import FirebaseFirestore

struct SleepContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @Binding var fallingAsleepTime: Date
    @Binding var wakeUpTime: Date
    
    let sleepReference = Firestore.firestore().collection("sleep")
        
    @State var fmtDate: DateFormatter = {
        var fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "yyyy/MM/dd"
        return fmt
    }()
    
    @State var fmtTime: DateFormatter = {
        var fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "HH:mm"
        return fmt
    }()
        
    var body: some View {
        NavigationView {
            VStack {
                Text("睡眠データの数: \(healthKitModel.dataSource.count)")
                if healthKitModel.dataSource.count == 0 {
                    Text("睡眠データなし")
                } else {
                    Text("最初の睡眠データのid: \(healthKitModel.dataSource[0].id)")
                    Button {
                        healthKitModel.saveSleeps(dataSource: healthKitModel.dataSource)
                    } label: {
                        Text("睡眠データの登録")
                    }
                }
                List {
                    if healthKitModel.dataSource.count == 0 {
                        Text("データがありません")
                    } else {
                        ForEach( healthKitModel.dataSource ) { item in
                            
                        }
                        ForEach( healthKitModel.dataSource ){ item in
                            HStack{
                                if item.sleepStatus == "0" {
                                    Text("全就寝時間")
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
                                Text(fmtTime.string(from: item.startDateTime) + " ~ " + fmtTime.string(from: item.endDateTime))
                            }
                        }
                    }
                }
            }.onAppear {
                healthKitModel.getSleepAnalysis(fallingAsleepTime: fallingAsleepTime, wakeUpTime: wakeUpTime)
            }.onDisappear {
                healthKitModel.dataSource.removeAll()
            }
        }
    }
}
