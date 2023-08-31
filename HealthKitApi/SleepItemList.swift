//
//  SleepItemList.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/31.
//

import SwiftUI

struct SleepItemList : Identifiable {
    var id: String
    var startDataTime: Data
    var endDateTime: Date
    var sleepStatus: String
}
