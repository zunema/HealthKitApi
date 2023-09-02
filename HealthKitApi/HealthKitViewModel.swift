//
//  HealthKitViewModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/31.
//

import SwiftUI
import Combine
import HealthKit

class HealthKitViewModel: ObservableObject, Identifiable {
    
    @Published var sleepData:[SleepItemList] = []
    
    
}
