//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI

struct SleepContentView: View {
    
    @ObservedObject var healthKitVM: HealthKitViewModel
    let dateformatter = DateFormatter()
    let day = Date()
    
    init(){
        
        healthKitVM = HealthKitViewModel()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -7, to: day)!
 
        dateformatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateformatter.locale = Locale(identifier: "ja_JP")
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        print("一週間前は\(dateformatter.string(from: modifiedDate))")
        print("今日は\(dateformatter.string(from: day))")
        
        // 睡眠データを取得する関数を呼ぶ（引数は期間）
        healthKitVM.get(
            fromDate: dateformatter.date(from: dateformatter.string(from: modifiedDate))!,
            toDate: dateformatter.date(from: dateformatter.string(from: day))!
        )
    }
    
    var body: some View {
        VStack {
            List {
                if healthKitVM.sleepData.count == 0 {
                    Text("データがありません。")
                } else {
                    ForEach( healthKitVM.sleepData ){ item in
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
                            Text(dateformatter.string(from: item.startDateTime))
                            Text(dateformatter.string(from: item.endDateTime))
                            Text("ステータス: \(item.sleepStatus)")
                        }
                    }
                }
            }.navigationBarTitle(Text("睡眠一覧"), displayMode: .inline)
        }
    }
}
