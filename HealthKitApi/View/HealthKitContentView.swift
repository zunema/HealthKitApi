//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import Combine
import HealthKit

struct HealthKitContentView: View {
    
    @EnvironmentObject var healthKitModel: HealthKitModel
    @State private var fallingAsleepTime = Date()
    @State private var wakeUpTime = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        VStack {
            
            DatePicker(selection: $fallingAsleepTime) {
                HStack {
                    Image(systemName: "moon")
                    Text("入眠時刻を任意で指定")
                }
            }
            DatePicker(selection: $wakeUpTime) {
                HStack {
                    Image(systemName: "sun.haze")
                    Text("起床時刻を任意で指定")
                }
            }
            if healthKitModel.permissionFlg {
                NavigationLink(destination: SleepContentView(fallingAsleepTime: $fallingAsleepTime, wakeUpTime: $wakeUpTime)) {
                    Text("夢の取得情報を確認")
                }
            }

        }
    }
}
