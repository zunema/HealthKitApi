//
//  HealthKitController.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import HealthKit
import FirebaseFirestore

/** ヘルスキットモデル */
class HealthKitModel: ObservableObject {
    
    @Published var sleepItem: [SleepItem] = []
    @Published var heartRateItem: [HeartRateItem] = []
    @Published var restingHeartRateItem: [RestingHeartRateItem] = []
    @Published var heartRateVariabilitySDNNItem: [HeartRateVariabilitySDNNItem] = []
    @Published var activeEnergyBurnedItem: [ActiveEnergyBurnedItem] = []
    var healthStore: HKHealthStore!
    var permissionMessage: String = ""
    var permissionFlg: Bool = false
    let sleepReference = Firestore.firestore().collection("sleep")
    
    // 消費エネルギー、サイクリング、ウォーキング/ランニングの距離、心拍数、安静時心拍数、睡眠
    // ↑の共有と読み出しに関する許可要求設定
    let allTypes = Set([HKObjectType.workoutType(),
                        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
                        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                        HKObjectType.quantityType(forIdentifier: .heartRate)!,
                        HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
                        HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
    
    init?() {
        if !HKHealthStore.isHealthDataAvailable() {
            return nil
        }

        self.healthStore = HKHealthStore()
        
        // 許可要求を発行
        self.healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                self.permissionMessage = "許可要求“失敗“"
            } else {
                self.permissionMessage = "許可要求“成功“"
                self.permissionFlg = true
            }
            print(self.permissionMessage)
        }
    }
    
    /** 睡眠データの取得 */
    func getSleepInfo(fallingAsleepTime: Date, wakeUpTime: Date) {
        let query = HKSampleQuery(sampleType: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                                  predicate: HKQuery.predicateForSamples(withStart: fallingAsleepTime, end: wakeUpTime, options: []),
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in

            guard error == nil else { print("睡眠データの取得“失敗“"); return }
            // ここで取得した睡眠データを扱える形に整形する
            if let resultDatas = results as? [HKCategorySample] {
                print("睡眠データの取得“成功“")
                for item in resultDatas {
                    let listItem = SleepItem(
                        id: item.uuid.uuidString,
                        startDateTime: item.startDate,
                        endDateTime: item.endDate,
                        sleepStatus: item.value.description
                    )
                    DispatchQueue.main.async {
                        self.sleepItem.append(listItem)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    
    /** 心拍数を取得 */
    func getHeartRateInfo(startTime: Date, endTime: Date) {
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
                                        predicate: HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: []),
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            guard error == nil else { print("error"); return }
            
            if let resultDatas = results as? [HKQuantitySample] {
                print("心拍数データの取得“成功“")
                for item in resultDatas {
                    let listItem = HeartRateItem(
                        id: item.uuid.uuidString,
                        datetime: item.endDate,
                        count: Int(item.quantity.doubleValue(for: HKUnit(from: "count/min")))
                    )
                    DispatchQueue.main.async {
                        self.heartRateItem.append(listItem)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    
    /** 安静時心拍数を取得 */
    func getRestingHeartRateInfo(startTime: Date, endTime: Date) {
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!,
                                        predicate: HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: []),
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            guard error == nil else { print("error"); return }
            
            if let resultDatas = results as? [HKQuantitySample] {
                print("安静時心拍数データの取得“成功“")
                for item in resultDatas {
                    let listItem = RestingHeartRateItem(
                        id: item.uuid.uuidString,
                        datetime: item.endDate,
                        count: Int(item.quantity.doubleValue(for: HKUnit(from: "count/min")))
                    )
                    DispatchQueue.main.async {
                        self.restingHeartRateItem.append(listItem)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    
    /** 心拍変動を取得 */
    func getHeartRateVariabilitySDNNInfo(startTime: Date, endTime: Date) {
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)!,
                                        predicate: HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: []),
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            guard error == nil else { print("error"); return }
            
            if let resultDatas = results as? [HKQuantitySample] {
                print("心拍変動データの取得“成功“")
                for item in resultDatas {
                    let listItem = HeartRateVariabilitySDNNItem(
                        id: item.uuid.uuidString,
                        startTime: item.startDate,
                        endTime: item.endDate,
                        count: Int(item.quantity.doubleValue(for: HKUnit(from: "ms")))
                    )
                    DispatchQueue.main.async {
                        self.heartRateVariabilitySDNNItem.append(listItem)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    
    /** アクティブエネルギーを取得 */
    func getActiveEnergyBurned(startTime: Date, endTime: Date) {
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                                        predicate: HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: []),
                                        limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
            
            guard error == nil else { print("error"); return }
            
            if let resultDatas = results as? [HKQuantitySample] {
                print("アクティブエネルギーデータの取得“成功“")
                for item in resultDatas {
                    let listItem = ActiveEnergyBurnedItem(
                        id: item.uuid.uuidString,
                        startDateTime: item.startDate,
                        endDateTime: item.endDate,
                        kcal: Double(item.quantity.doubleValue(for: HKUnit(from: "kcal")))
                    )
                    DispatchQueue.main.async {
                        self.activeEnergyBurnedItem.append(listItem)
                    }
                }
            }
        }
        healthStore.execute(query)
    }

}
