//
//  GameViewController.swift
//  BaiTap1
//
//  Created by Katharos on 01/11/2023.
//

import UIKit

final class GameViewController: BaseViewController {
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var checkmarks: [UIImageView]!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var playButton: CustomButton!
    @IBOutlet weak var playAgainButton: CustomButton!
    
    private var selectedButton: UIButton?
    private var timer: Timer?
    private var money: Int = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        setupGameButtons(buttons: buttons)
    }
    
    private func setupGameButtons(buttons: [UIButton]) {
        hideCheckmark()
        
        buttons.forEach { button in
//            button.layer.cornerRadius = 8
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.1
            button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            button.layer.shadowRadius = 4
            button.layer.masksToBounds = false
            button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func hideCheckmark() {
        checkmarks.forEach { $0.isHidden = true }
    }
    
    private func resetUserInteraction() {
        buttons.forEach { button in
            button.isUserInteractionEnabled = true
        }
    }
    
    private func resetButtonColors() {
        buttons.forEach { button in
            button.backgroundColor = .white
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        checkmarks.forEach { $0.isHidden = $0.tag != sender.tag }
        
//        // Showing multiple checkmarks:
//        checkmarks.first { $0.tag == sender.tag }?.isHidden.toggle()
        
        selectedButton = sender
    }
    
    @IBAction func didTapPlay() {
        guard money > 0 else {
            let alertController = UIAlertController(title: "Oops!", message: "Bạn không đủ tiền cược!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Rời đi", style: .cancel)
            
            let yesAction = UIAlertAction(title: "Nhận thêm 10000$", style: .default) { [self] _ in
                money += 10000
                moneyLabel.text = "Tổng tiền: \(money)$"
            }
            
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            
            show(vc: alertController)
            return
        }
        
        let selectedButtons = checkmarks.filter { !$0.isHidden }
        guard !selectedButtons.isEmpty else {
            let alertController = UIAlertController(title: "Oops", message: "Bạn chưa đặt cược số nào. Vui lòng đặt cược!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
                hideCheckmark()
            }
            
            alertController.addAction(okAction)
            
            show(vc: alertController)
            return
        }
        
        let alertController = UIAlertController(title: "Đặt cược", message: "Bạn muốn đặt cược số đã chọn?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Đặt cược", style: .default) { [self] _ in
            startPlaying()
        }
        
        let noAction = UIAlertAction(title: "Huỷ", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        
        show(vc: alertController)
        
    }
    
    @IBAction func didTapPlayAgain() {
        resetUI()
    }
    
    private func resetUI() {
        hideCheckmark()
        resetButtonColors()
        resetUserInteraction()
        resetMoneyLabel()
        playButton.isUserInteractionEnabled = true
    }
    
    private func resetMoneyLabel() {
        money = 10000
        moneyLabel.text = "Tổng tiền: \(money)$"
    }
    
    private func startPlaying() {
        playButton.isUserInteractionEnabled = false
        playAgainButton.isUserInteractionEnabled = false
        
        resetUserInteraction()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shuffleButtons), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            self.timer?.invalidate()
            self.timer = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                let title: String
                let message: String
                let moneyChange: Int
                
                if selectedButton?.backgroundColor == .green {
                    title = "Chúc mừng bạn đã thắng cược!"
                    message = "Bạn nhận được 2000$"
                    moneyChange = 2000
                } else {
                    title = "Thua cược!"
                    message = "Bạn mất đi 1000$"
                    moneyChange = -min(money, 1000)
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
                    money += moneyChange
                    moneyLabel.text = "Tổng tiền: \(money)$"
                    
                    resetButtonColors()
                    resetUserInteraction()
                    playButton.isUserInteractionEnabled = true
                    playAgainButton.isUserInteractionEnabled = true
                }
                
                alertController.addAction(okAction)
                
                show(vc: alertController)
            }
            
            playAgainButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func shuffleButtons() {
        let randomTag = Int.random(in: 1...buttons.count)
        
        buttons.forEach { button in
            button.backgroundColor = button.tag == randomTag ? .red : .white
            
            if button == selectedButton, selectedButton?.tag == randomTag {
                selectedButton?.backgroundColor = .green
            }
            
            button.isUserInteractionEnabled = false
        }
    }
}
