//
//  SleepItem.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/18.
//

import SwiftUI

struct SleepItem: Identifiable {
    var id: ObjectIdentifier
    
    var sleepId: String
    var startDateTime: Date
    var endDateTime: Date
    var sleepStatus: String
}
