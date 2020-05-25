//
//  ViewController.swift
//  Example
//
//  Created by Mustafa GUNES on 25.05.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

import UIKit
import RxSwift
import RxBatteryManager

class ViewController: UIViewController {
    
    // MARK: - Global Definitions
    let battery = Battery.monitor
    let disposeBag = DisposeBag()
    
    // MARK: - Outlets
    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryStateLabel: UILabel!
    @IBOutlet weak var isLowPowerModeLabel: UILabel!
    @IBOutlet weak var isLowBatteryLabel: UILabel!
    @IBOutlet weak var isCriticalBatteryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
    }
    
    deinit {
        battery.stop()
    }
    
    func setObserver() {
        battery.level
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] level in
            guard let self = self else { return }
            self.batteryLevelLabel.text = "\(level)"
        }).disposed(by: disposeBag)
        
        battery.state
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .unknown:
                self.batteryStateLabel.text = "unknown"
            case .unplugged:
                self.batteryStateLabel.text = "unplugged"
            case .charging:
                self.batteryStateLabel.text = "charging"
            case .full:
                self.batteryStateLabel.text = "full"
            @unknown default:
                fatalError()
            }
        }).disposed(by: disposeBag)
        
        battery.isLowPowerMode
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] isLowPowerMode in
            guard let self = self else { return }
            self.isLowPowerModeLabel.text = "\(isLowPowerMode)"
        }).disposed(by: disposeBag)
        
        battery.isLowLevel
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] isLowLevel in
            guard let self = self else { return }
            self.isLowBatteryLabel.text = "\(isLowLevel)"
        }).disposed(by: disposeBag)
        
        
        battery.isCriticalLevel
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] isCriticalLevel in
            guard let self = self else { return }
            self.isCriticalBatteryLabel.text = "\(isCriticalLevel)"
        }).disposed(by: disposeBag)
    }
}
