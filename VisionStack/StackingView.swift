//
//  StackingView.swift
//  VisionStack
//
//  Created by Eason on 8/1/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct StackingView: View {
    @StateObject var model = HandTrackingViewModel()

    var body: some View {
        RealityView { content in
            // add content entity
            content.add(model.setupContentEntity())
        }.task {
            // run ARKit session
            await model.runSession()
        }.task {
            // process Hand updates
            await model.processHandUpdates()
        }.task {
            // process word reconstruction
        }.gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in
            Task {
                // gesture
            }
        }))
    }
}

#Preview {
    StackingView()
}
