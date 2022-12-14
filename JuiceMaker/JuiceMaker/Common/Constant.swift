//
//  Constant.swift
//  JuiceMaker
//
//  Created by Kyo, TaeLee on 2022/09/01.
//

enum ConstantUsageFruit {
    static let strawberry: Int = 16
    static let banana: Int = 2
    static let pineapple: Int = 2
    static let kiwi: Int = 3
    static let mango: Int = 3
    static let strawberryBanana: (strawberry: Int, banana: Int) = (10, 1)
    static let mangoKiwi: (mango: Int, kiwi: Int) = (2, 2)
    static let invalidFruit: Int = -1
}

enum ConstantSentence {
    static let mainTitle: String =  "맛있는 주스를 만들어 드려요!"
    static let successAlertMent: String = " 나왔습니다! 맛있게 드세요!"
    static let failedAlertMent: String = "재료가 모자라요. 재고를 수정할까요?"
    static let modifyStockTitle: String = "재고 추가"
}
