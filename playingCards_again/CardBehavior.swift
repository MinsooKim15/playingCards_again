//
//  CardBehavior.swift
//  playingCards_again
//
//  Created by minsoo kim on 2018. 9. 29..
//  Copyright © 2018년 minsoo kim. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior
{
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var itemBehavior : UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem){
        let push = UIPushBehavior(items:[item], mode: .instantaneous)
        // push의 각도를 랜덤하게 밈 >> push.angle = (2*CGFloat.pi).arc4random
        // push를 중앙을 향해 밈
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            push.angle = (CGFloat.pi/2).arc4random
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y > center.y:
                push.angle = -1 * push.angle
            case let (x, y) where x > center.x:
                push.angle = y < center.y ? CGFloat.pi-push.angle: CGFloat.pi+push.angle
            default:
                push.angle = (CGFloat.pi*2).arc4random
            }
        }
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }

    func addItem(_ item: UIDynamicItem){
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }

    func removeItem(_ item: UIDynamicItem){
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init(){
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }

    convenience init(in animator: UIDynamicAnimator){
        self.init()
        animator.addBehavior(self)
    }
}
