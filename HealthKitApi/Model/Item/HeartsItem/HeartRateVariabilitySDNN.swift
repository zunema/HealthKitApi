//
//  HeartRateVariabilitySDNN.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/11.
//

import SwiftUI

/** 心拍変動アイテム */
struct HeartRateVariabilitySDNNItem: Identifiable {
    var id: String
    var startTime: Date
    var endTime: Date
    var count: Int
}

