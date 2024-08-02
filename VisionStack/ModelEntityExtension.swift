//
//  ModelEntityExtension.swift
//  VisionStack
//
//  Created by Eason on 8/1/24.
//

import RealityKit

extension ModelEntity {
    class func createFingertip() -> ModelEntity {
        let entity = ModelEntity(
            mesh: .generateSphere(radius: 0.01),
            materials: [UnlitMaterial(color: .cyan)],
            collisionShape: .generateSphere(radius: 0.005),
            mass: 0.0
            )
        
        entity.components.set(PhysicsBodyComponent(mode: .kinematic))
        entity.components.set(OpacityComponent(opacity: 0.5))
        
        return entity
    }
}
