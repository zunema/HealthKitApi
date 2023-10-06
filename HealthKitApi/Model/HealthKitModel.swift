//
//  HealthKitController.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import HealthKit
import FirebaseFirestore

class HealthKitModel: ObservableObject {
    
    @Published var dataSource: [SleepItem] = []
    var healthStore: HKHealthStore!
    var permissionMessage: String = ""
    var permissionFlg: Bool = false
    var textConfirm: String = "確認OK。"
    let sleepReference = Firestore.firestore().collection("sleep")
    
    // 消費エネルギー、サイクリング、ウォーキング、ランニングの距離と心拍数の共有と読み出しに関する許可要求設定
    let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                        HKObjectType.quantityType(forIdentifier: .heartRate)!,
                        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
    
    init?() {
        if !HKHealthStore.isHealthDataAvailable() {
            return nil
        }

        self.healthStore = HKHealthStore()
        
        // 許可要求を発行
        self.healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                self.permissionMessage = "許可要求失敗"
            } else {
                self.permissionMessage = "許可要求成功"
                self.permissionFlg = true
            }
            print(self.permissionMessage)
        }
    }
    
    // 睡眠データの取得
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
                }
            }
        }
        healthStore.execute(query)
    }
    
    // 睡眠データの保存(このメソッドが原因でエラーになってそう)
//    func saveSleeps(dataSource:[SleepItem]) -> Void {
//        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
//            for item in dataSource {
//                let sleepReference = self.sleepReference.document(item.id)
//                transaction.setData([
//                    "status": item.sleepStatus,
//                    "start": item.startDateTime,
//                    "end": item.endDateTime
//                ], forDocument: sleepReference)
//            }
//            return nil
//        }, completion: { (_, error)  in
//            if let error = error {
//                print(error)
//                return
//            }
//        })
//    }

}
