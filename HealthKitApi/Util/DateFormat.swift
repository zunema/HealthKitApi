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
    
    /** 現在時刻の取得 */
    func getCurrentTime() -> Date {
        let now = Calendar.current.date(byAdding: .hour, value: 9, to: Date())!
        return now
    }
    
    /** 挨拶メッセージを返す */
    func getGreetingMessage() -> String {
        // 現在の時刻を生成
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HHmmss", options: 0, locale: Locale(identifier: "ja_JP"))
        let now = dateFormatter.string(from: date)
        var massage: String
        
        if now.compare("04:00:00") == ComparisonResult.orderedDescending && now.compare("09:00:00") == ComparisonResult.orderedAscending {
            massage = "おはございます"
        } else if (now.compare("09:01:00") == ComparisonResult.orderedDescending && now.compare("18:00:00") == ComparisonResult.orderedAscending) {
            massage = "こんにちは"
        } else if (now.compare("018:01:00") == ComparisonResult.orderedDescending && now.compare("24:00:00") == ComparisonResult.orderedAscending) {
            massage = "こんばんは"
        } else {
            massage = "夜遅くにお疲れ様です"
        }
        
        return massage
    }
}
