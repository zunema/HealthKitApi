//
//  HealthKitViewModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/31.
//

import SwiftUI
import Combine
import HealthKit

class HealthKitViewModel: ObservableObject, Identifiable {
    
    @Published var sleepData:[SleepItemList] = []
    
    func get( fromData: Data, toData: Data) {
        let healthStore = HKHealthStore()
        let readTypes = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        ])
        
        healthStore.requestAuthorization(toShare: [], read: readTypes, completion: { success, error in
            if success == false {
                print("データにアクセスできません。。。")
                return
            }
            
            // 睡眠データを取得
            let query = HKSampleQuery(sampleType: HKObjectType.categoryType(
                    forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
                    predicate: HKQuery.predicateForSamples(withStart: fromData, end: toData, options: []),
                    limit: HKObjectQueryNoLimit,
                    sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]
            ){ (query, results, error) in
                guard error == nil else {
                    print("error")
                    return
                }
                if let tmpResults = results as? [HKCategorySample] {
                    // 取得したデータを１件ずつ SleepItemList 構造体に格納
                    // SleepItemListは、sleepData配列に追加します。ViewのListでは、この sleepData配列を参照して睡眠状態を表示します。
                    for item in tmpResults {
                        
                        let sleepItem = SleepItemList(
                            id: item.uuid.uuidString,
                            startDataTime: item.startDate,
                            endDateTime: item.endDate,
                            sleepStatus: item.value.description
                        )
                        
                        self.sleepData.append(sleepItem)
                    }
                }
            }
            healthStore.execute(query)
            print(type(of: self.sleepData))
        })
        
    }
}
