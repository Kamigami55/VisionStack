//
//  VisionStackApp.swift
//  VisionStack
//
//  Created by Eason on 8/1/24.
//

import SwiftUI

@main
struct VisionStackApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            StackingView()
//            ImmersiveView()
//                .environment(appModel)
//                .onAppear {
//                    appModel.immersiveSpaceState = .open
//                }
//                .onDisappear {
//                    appModel.immersiveSpaceState = .closed
//                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
