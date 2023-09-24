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
        
    @State var fmt: DateFormatter = {
        var fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return fmt
    }()
        
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    healthKitModel.getSleepAnalysis(fallingAsleepTime: fallingAsleepTime, wakeUpTime: wakeUpTime)
                } label: {
                    Text("睡眠データの取得を試みる")
                }

                List {
                    if healthKitModel.dataSource.count == 0 {
                        Text("データがありません。")
                    } else {
                        ForEach( healthKitModel.dataSource ){ item in
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
                            HStack{
                                Text(fmt.string(from: item.startDateTime))
                                Text(fmt.string(from: item.endDateTime))
                                Text("ステータス: \(item.sleepStatus)")
                            }
                        }
                    }
                }
            }
        }
    }
}
