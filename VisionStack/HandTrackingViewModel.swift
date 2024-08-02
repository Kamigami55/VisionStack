//
//  HandTrackingViewModel.swift
//  VisionStack
//
//  Created by Eason on 8/1/24.
//

import RealityKit
import SwiftUI
import ARKit
import RealityKitContent

@MainActor class HandTrackingViewModel: ObservableObject {
    private let session = ARKitSession()
    private let handTracking = HandTrackingProvider()
    
    private var sceneReconstruction = SceneReconstructionProvider()
    
    private var contentEntity = Entity()
    
    private var meshEntities = [UUID: ModelEntity]()
    
    private let fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
        .left: .createFingertip(),
        .right: .createFingertip()
    ]
    
    private var lastCubePlacementTime: TimeInterval = 0
    
    func setupContentEntity() -> Entity {
        for entity in fingerEntities.values {
            contentEntity.addChild(entity)
        }
        
        return contentEntity
    }
    
    func runSession () async {
        do {
            try await session.run([sceneReconstruction, handTracking])
        } catch {
            print("Failed to start session: \(error)")
        }
    }
    
    func processHandUpdates() async {
        for await update in handTracking.anchorUpdates {
            let handAnchor = update.anchor
            
            guard handAnchor.isTracked else {
                continue
            }
            
            let fingerTip = handAnchor.handSkeleton?.joint(.indexFingerTip)
            
            guard ((fingerTip?.isTracked) != nil) else {
                continue
            }
            
            let originFromWrist = handAnchor.originFromAnchorTransform
            let wristFromIndex = fingerTip?.anchorFromJointTransform
            let originFromIndex = originFromWrist * wristFromIndex!
            
            fingerEntities[handAnchor.chirality]?
                .setTransformMatrix(originFromIndex, relativeTo: nil)
        }
    }
}
