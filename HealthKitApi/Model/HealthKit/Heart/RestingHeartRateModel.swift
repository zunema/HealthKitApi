//
//  RestingHeartRateModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

class RestingHeartRateModel: ObservableObject {
    
    let restingHeartRateReference = Firestore.firestore().collection("restingHeartRate")
    
    /** 安静時心拍数データの保存 */
    func saveRestingHeartRates(dataSource:[RestingHeartRateItem]) -> Void {
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            for item in dataSource {
                transaction.setData([
                    "datetime": item.datetime,
                    "count": item.count,
                    "userId": Auth.auth().currentUser!.uid
                ], forDocument: self.restingHeartRateReference.document(item.id))
            }
            print("安静時心拍数データの保存“成功“")
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                print(error)
                return
            }
        })
    }

}
