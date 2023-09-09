//
//  HealthKitController.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import HealthKit

class HealthKitController: ObservableObject, Identifiable {
    
    var healthStore: HKHealthStore!
    var permissionMessage: String = ""
    
    // 消費エネルギー、サイクリング、ウォーキング、ランニングの距離と心拍数の共有と読み出しに関する許可要求設定
    let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                        HKObjectType.quantityType(forIdentifier: .heartRate)!,
                        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
    
    // 睡眠用
    // 1. データのタイプを指定
    let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    
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
                self.permissionMessage = "許可要求失敗。。"
                print("エラー発生してる。。。")
            } else {
                self.permissionMessage = "許可要求成功!!"
                print("成功！")
            }
        }
    }
    
    func getPermissionConfirmation() {
    }
    
}
