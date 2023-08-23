//
//  UserConfirm.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI

struct UserConfirm: View {
    
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        VStack {
            Text(userID)
        }
    }
}
