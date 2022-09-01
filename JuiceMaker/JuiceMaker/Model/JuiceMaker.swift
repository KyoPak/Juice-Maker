//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

struct JuiceMaker {
    let fruitStore = FruitStore()
    
    func manufactureJuice(orderJuice: Juice) {
        guard canManufactureJuice(juice: orderJuice) else {
            return
        }
        
        fruitStore.substractFruits(juice: orderJuice)
    }
    
    func checkEnoughStock(juice: Juice) throws -> Bool {
        for fruit in juice.recipe {
            let stock = fruitStore.bringValidFruitStock(fruit.name)
            
            guard stock != ConstantUsageFruit.invalidFruit else {
                return false
            }
            
            guard stock >= fruit.count else {
                throw JuiceMakerError.outOfStock
            }
        }
        
        return true
    }
    
    func canManufactureJuice(juice: Juice) -> Bool {
        var isEnoughStock: Bool = false
        
        do {
            isEnoughStock = try checkEnoughStock(juice: juice)
            return isEnoughStock
        } catch JuiceMakerError.outOfStock {
            print("과일 재고 품절입니다.")
        } catch {
            print("some error")
        }
        
        return isEnoughStock
    }
}
