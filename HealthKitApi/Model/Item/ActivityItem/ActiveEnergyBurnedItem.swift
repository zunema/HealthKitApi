//
//  ActiveEnergyBurnedItem.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI

/** アクティビティエネルギーアイテム */
struct ActiveEnergyBurnedItem: Identifiable {
    var id: String
    var startDateTime: Date
    var endDateTime: Date
    var kcal: Double
}
