//
//  DateFormat.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/12.
//

import SwiftUI

struct DateFormat {
    
    /** 年月日のフォーマット */
    func getDate() -> DateFormatter {
        let fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "yyyy/MM/dd"
        return fmt
    }
    
    /** 時分のフォーマット */
    func getHoursAndMinutes() -> DateFormatter {
        let fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Tokyo")
        fmt.locale = Locale(identifier: "ja_JP")
        fmt.dateFormat = "HH:mm"
        return fmt
    }
}
