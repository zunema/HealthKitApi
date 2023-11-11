//
//  HeartRateVariabilitySDNNModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/11.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

class HeartRateVariabilitySDNNModel: ObservableObject {
    
    let restingHeartRateReference = Firestore.firestore().collection("heartRateVariabilitySDNN")
    
    /** 心拍数変動データの保存 */
    func saveHeartRatesVariabilitySDNN(dataSource:[HeartRateVariabilitySDNNItem]) -> Void {
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            for item in dataSource {
                transaction.setData([
                    "startTime": item.startTime,
                    "endTime": item.endTime,
                    "count": item.count,
                    "userId": Auth.auth().currentUser!.uid
                ], forDocument: self.restingHeartRateReference.document(item.id))
            }
            print("心拍数変動データの保存“成功“")
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                print(error)
                return
            }
        })
    }

}
