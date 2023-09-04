//
//  SleepContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/02.
//

import SwiftUI
import Combine
import HealthKit

struct HealthKitContentView: View {
    
    @ObservedObject var healthKitController: HealthKitController
    
    var body: some View {
        VStack {
            Text(healthKitController.permissionMessage)
        }
    }
}
