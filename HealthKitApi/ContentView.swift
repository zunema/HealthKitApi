//
//  ContentView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var authStateManager = FirebaseAuthStateManager()
    @State var isShowSheet = false
    
    var body: some View {
        VStack {
            if authStateManager.signInState == false {
                // サインアウト状態なのでサインインボタンを表示する
                Button(action: {
                    self.isShowSheet.toggle()
                }) {
                    Text("サインイン")
                }
            } else {
                UserConfirm()
                // Sign-In状態なのでSign-Outボタンを表示する
                Button(action: {
                    authStateManager.signOut()
                }) {
                    Text("サインアウト")
                }
            }
        }
        .sheet(isPresented: $isShowSheet) {
            FirebaseUIView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
