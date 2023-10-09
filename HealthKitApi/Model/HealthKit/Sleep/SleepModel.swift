//
//  SleepModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/08.
//

import SwiftUI
import FirebaseFirestore

class SleepModel: ObservableObject {
    
    @Published var dataSource: [SleepItem] = []
    let sleepReference = Firestore.firestore().collection("sleep")
    
    // 睡眠データの保存
    func saveSleeps(dataSource:[SleepItem]) -> Void {
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            for item in dataSource {
                transaction.setData([
                    "status": item.sleepStatus,
                    "start": item.startDateTime,
                    "end": item.endDateTime
                ], forDocument: self.sleepReference.document(item.id))
            }
            print("睡眠データの保存“成功“")
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                print(error)
                return
            }
        })
    }

}
