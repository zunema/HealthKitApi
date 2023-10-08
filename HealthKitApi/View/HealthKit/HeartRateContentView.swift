//
//  HeartRateContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/08.
//

import SwiftUI
import FirebaseFirestore

struct HeartRateContentView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @ObservedObject var heartRateModel: HeartRateModel
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
                healthKitModel.getHeartRateAnalysis(startTime: fallingAsleepTime, endTime: wakeUpTime)
            }
            .onDisappear {
                Task.detached { @MainActor in
                    healthKitModel.sleepItem.removeAll()
                }
            }
        }
    }
}

