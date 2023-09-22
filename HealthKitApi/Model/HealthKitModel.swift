//
//  HealthKitController.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import HealthKit

class HealthKitModel: ObservableObject, Identifiable {
    
    var healthStore: HKHealthStore!
    var permissionMessage: String = ""
    var permissionFlg: Bool = false
    var textConfirm: String = "確認OK。"
    var dataSource:[SleepItem] = []
    
    // 消費エネルギー、サイクリング、ウォーキング、ランニングの距離と心拍数の共有と読み出しに関する許可要求設定
    let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                        HKObjectType.quantityType(forIdentifier: .heartRate)!,
                        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
    
    // 睡眠用
    // 1. データのタイプを指定
    // let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    
    // 2. 開始/終了時刻
    // let startDate = Calendar.current.date(bySettingHour: 01:00, minute: 00, second: 0, of: Date())!
    // let endDate = Calendar.current.date(bySettingHour: 07:00, minute: 00, second: 0, of: Date())!
    
    // 3. 上記の要素を一つのデータとしてまとめる
    //    let sample = HKCategorySample(
    //        type: sleepType,
    //        value: HKCategoryValueSleepAnalysis.inBed.rawValue,
    //        start: startDate,
    //        end: endDate
    //    )
    
    // 4. 上記の要素を一つのデータとしてまとめる
    //    self.healthStore.save(sample) { success, error in
    //        if success {
    //            print("success")
    //        } else {
    //            print("failed")
    //        }
    //    }

    
    init?() {
        if !HKHealthStore.isHealthDataAvailable() {
            return nil
        }

        self.healthStore = HKHealthStore()
        
        // 許可要求を発行
        self.healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                // エラーが発生した場合の処理を実装
                self.permissionMessage = "許可要求失敗"
                print("エラー発生")
            } else {
                self.permissionMessage = "許可要求成功"
                self.permissionFlg = true
                print("成功")
            }
        }
    }
    
    func getSleepAnalysis(fallingAsleepTime: Date, wakeUpTime: Date)  {
        let query = HKSampleQuery(sampleType: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                                  predicate: HKQuery.predicateForSamples(withStart: fallingAsleepTime, end: wakeUpTime, options: []),
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            guard error == nil else { print("睡眠データを取得失敗"); return }
            // ここで取得した睡眠データを扱える形に整形する
            if let results = results as? [HKCategorySample] {
                print("取得成功!!")
                for item in results {
                    let listItem = SleepItem(
                        id: item.uuid.uuidString,
                        startDateTime: item.startDate,
                        endDateTime: item.endDate,
                        sleepStatus: item.value.description
                    )
                    self.dataSource.append(listItem)
                    print("取得成功したかな...")
                    print(listItem.sleepStatus)
                }
            }
        }
        healthStore.execute(query)
        print(type(of: self.dataSource))
    }
}
