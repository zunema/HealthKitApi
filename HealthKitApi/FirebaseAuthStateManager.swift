//
//  FirebaseAuthStateManager.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/23.
//

import FirebaseAuth

class FirebaseAuthStateManager: ObservableObject {
    @Published var signInState: Bool = false
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let _ = user {
                print("サインイン")
                self.signInState = true
            } else {
                print("サインアウト")
                self.signInState = false
            }
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("エラー")
        }
    }
}
