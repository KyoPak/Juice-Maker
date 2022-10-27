//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceMakerViewController: UIViewController {
    var juiceMaker = JuiceMaker()
    private var fruitLabel: [Fruit : UILabel] = [:]
    
    @IBOutlet weak var strawberryStockLabel: UILabel!
    @IBOutlet weak var bananaStockLabel: UILabel!
    @IBOutlet weak var pineappleStockLabel: UILabel!
    @IBOutlet weak var kiwiStockLabel: UILabel!
    @IBOutlet weak var mangoStockLabel: UILabel!

    @IBOutlet var orderButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setFruitLabel()
        setupLabelDynamicType()
        setupButtonDynamicType()
        setFruitStockLabelText()
    }
    
    private func setupLabelDynamicType() {
        strawberryStockLabel.adjustsFontForContentSizeCategory = true
        bananaStockLabel.adjustsFontForContentSizeCategory = true
        pineappleStockLabel.adjustsFontForContentSizeCategory = true
        kiwiStockLabel.adjustsFontForContentSizeCategory = true
        mangoStockLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func setupButtonDynamicType() {
        orderButtons.forEach { button in
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBAction func modifyStockButtonTapped(_ sender: Any) {
        guard let modifyStockVC = storyboard?.instantiateViewController(withIdentifier: "ModifyVC") as? ModifyStockViewController else {
            return
        }
        
        modifyStockVC.fruitStock = juiceMaker.fruitStore.fruitStock
        modifyStockVC.delegate = self
        let moveToStockNC = UINavigationController(rootViewController: modifyStockVC)
        present(moveToStockNC, animated: true, completion: nil)
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        guard let orderedJuice = Juice.findJuiceButtonTag(location: sender.tag) else {
            return
        }
                
        let isMadeJuice =  juiceMaker.manufactureJuice(menu: orderedJuice)
        guard isMadeJuice else {
            showFailedAlert(message: ConstantSentence.failedAlertMent)
            return
        }
        
        showSuccessAlert(message: orderedJuice.rawValue + ConstantSentence.successAlertMent)
        setFruitStockLabelText()
    }

    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "예", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    private func showFailedAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "예", style: .default) { _ in
            guard let modifyStockVC = self.storyboard?.instantiateViewController(withIdentifier: "ModifyVC") as? ModifyStockViewController else {
                return
            }
            
            modifyStockVC.fruitStock = self.juiceMaker.fruitStore.fruitStock
            modifyStockVC.delegate = self
            let moveToStockNC = UINavigationController(rootViewController: modifyStockVC)
            self.present(moveToStockNC, animated: true, completion: nil)
        }
        
        let cancleAction = UIAlertAction(title: "아니오", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancleAction)
        self.present(alert, animated: true)
    }
    
    private func setFruitLabel() {
        fruitLabel = [.strawberry : strawberryStockLabel,
                      .banana : bananaStockLabel,
                      .pineapple : pineappleStockLabel,
                      .kiwi : kiwiStockLabel,
                      .mango : mangoStockLabel]
    }
    
    private func setNavigationBar() {
        self.title = ConstantSentence.mainTitle
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 242/255,
                                                                           green: 242/255,
                                                                           blue: 242/255,
                                                                           alpha: 1.0)
    }
    
    private func setFruitStockLabelText() {
        let fruitStore = juiceMaker.fruitStore
        for (key, value) in fruitLabel {
            value.text = String(fruitStore.bringValidFruitStock(key))
        }
    }
}

extension JuiceMakerViewController: ModifyStockDelegate {
    func changeFruitStock(_ changedStock: [Fruit : Int]) {
        juiceMaker.passingChangedFruitStock(changedStock)
        setFruitStockLabelText()
    }
}


extension JuiceMakerViewController: UIAccessibilityReadingContent {
    func accessibilityLineNumber(for point: CGPoint) -> Int {
        return 10
    }
    
    func accessibilityContent(forLineNumber lineNumber: Int) -> String? {
        return ""
    }
    
    func accessibilityFrame(forLineNumber lineNumber: Int) -> CGRect {
        return CGRect(x: 10, y: 10, width: 10, height: 10)
    }
    
    func accessibilityPageContent() -> String? {
        var a = strawberryStockLabel.text
        var b = bananaStockLabel.text
        var c = pineappleStockLabel.text
        var d = kiwiStockLabel.text
        var e = mangoStockLabel.text
        return "\(a),\(b),\(c),\(d),\(e)"
    }
    
    
}
