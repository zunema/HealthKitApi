//
//  RestingHeartRateItem.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/06.
//

import SwiftUI

/** 安静時心拍数アイテム */
struct RestingHeartRateItem: Identifiable {
    var id: String
    var datetime: Date
    var count: Int
}
