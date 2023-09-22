//
//  SleepDetailView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/22.
//

import SwiftUI

struct SleepDetailView: View {
    
    @ObservedObject var healthKitModel: HealthKitModel
    @Binding var fmt: DateFormatter
    
    var body: some View {
        NavigationView {
            List {
                if healthKitModel.dataSource.count == 0 {
                    Text("データがありません。")
                } else {
                    ForEach( healthKitModel.dataSource ){ item in
                        if item.sleepStatus == "0" {
                            Text("全就寝時間")
                        } else if item.sleepStatus == "1" {
                            Text("睡眠時間")
                        }else if item.sleepStatus == "2" {
                            Text("覚醒")
                        }else if item.sleepStatus == "3" {
                            Text("コア")
                        }else if item.sleepStatus == "4" {
                            Text("深い睡眠")
                        }else if item.sleepStatus == "5" {
                            Text("レム")
                        }
                        HStack{
                            Text(fmt.string(from: item.startDateTime))
                            Text(fmt.string(from: item.endDateTime))
                            Text("ステータス: \(item.sleepStatus)")
                        }
                    }
                }
            }.navigationBarTitle(Text("睡眠一覧"), displayMode: .inline)
        }
    }
}
