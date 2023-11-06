//
//  HeartRateModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/08.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

class HeartRateModel: ObservableObject {
    
    @Published var dataSource: [SleepItem] = []
    let heartRateReference = Firestore.firestore().collection("heartRate")
    
    /** 心拍数データの保存 */
    func saveHeartRates(dataSource:[HeartRateItem]) -> Void {
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            for item in dataSource {
                transaction.setData([
                    "datetime": item.datetime,
                    "count": item.count,
                    "userId": Auth.auth().currentUser!.uid
                ], forDocument: self.heartRateReference.document(item.id))
            }
            print("心拍数データの保存“成功“")
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                print(error)
                return
            }
        })
    }

}
