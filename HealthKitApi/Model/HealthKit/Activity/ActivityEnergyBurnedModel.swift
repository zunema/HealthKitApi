//
//  ActivityEnergyBurnedModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

class ActivityEnergyBurnedModel: ObservableObject {
    
    let activityEnergyBurnedReference = Firestore.firestore().collection("activityEnergyBurned")
    
    /** 睡眠データの保存 */
    func saveActivityEnergyBurneds(dataSource:[ActiveEnergyBurnedItem]) -> Void {
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            for item in dataSource {
                transaction.setData([
                    "kcal": item.kcal,
                    "start": item.startDateTime,
                    "end": item.endDateTime,
                    "userId": Auth.auth().currentUser!.uid
                ], forDocument: self.activityEnergyBurnedReference.document(item.id))
            }
            print("アクティブエネルギーデータの保存“成功“")
            return nil
        }, completion: { (_, error)  in
            if let error = error {
                print(error)
                return
            }
        })
    }

}
