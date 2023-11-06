//
//  HeartRateItem.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/08.
//

import SwiftUI

/** 心拍数アイテム */
struct HeartRateItem: Identifiable {
    var id: String
    var datetime: Date
    var count: String
}
