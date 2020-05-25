//
//  RxBatteryManager.swift
//  RxBatteryManager
//
//  Created by Mustafa GUNES on 25.05.2020.
//

import class UIKit.UIDevice
import class UIKit.ProcessInfo
import class UIKit.NotificationCenter
import class RxRelay.BehaviorRelay
import class RxSwift.PublishSubject

open class Battery {
    
    /// Singleton
    public static let monitor = Battery()
    
    /// Low Level
    open var isLowLevel: PublishSubject<Bool> = PublishSubject<Bool>()
    
    /// Critical Level
    open var isCriticalLevel: PublishSubject<Bool> = PublishSubject<Bool>()
    
    /// Battery Level
    open var level: BehaviorRelay<Float> = .init(value: UIDevice.current.batteryLevel)
    
    /// Battery State
    open var state: BehaviorRelay<UIDevice.BatteryState> = .init(value: UIDevice.current.batteryState)
    
    /// Battery Low Power Mode Enabled Status
    open var isLowPowerMode: BehaviorRelay<Bool> = .init(value: ProcessInfo.processInfo.isLowPowerModeEnabled)
    
    /// Battery Monitoring Enabled
    open var isEnabled: Bool = false {
        didSet {
            UIDevice.current.isBatteryMonitoringEnabled = isEnabled
        }
    }
    
    deinit {
        stopMonitor()
    }
    
    /// Start Monitoring
    open func startMonitor() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(lowerPowerModeChanged),
                                               name: .NSProcessInfoPowerStateDidChange,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(batteryLevelChanged),
                                               name: UIDevice.batteryLevelDidChangeNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(batteryStateChanged),
                                               name: UIDevice.batteryStateDidChangeNotification,
                                               object: nil)
    }
    
    /// Stop Monitor
    open func stopMonitor() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// LowerPowerMode Notify Changes
    @objc
    private func lowerPowerModeChanged() {
        isLowPowerMode.accept(ProcessInfo.processInfo.isLowPowerModeEnabled)
    }
    
    /// BatteryLevel Notify Changes
    @objc
    private func batteryLevelChanged() {
        level.accept(UIDevice.current.batteryLevel)
        
        if level.value > 0.2 {
            isLowLevel.onNext(false)
            isCriticalLevel.onNext(false)
        } else if level.value == 0.2 {
            isLowLevel.onNext(true)
        } else if level.value == 0.1 {
            isCriticalLevel.onNext(true)
        }
    }
    
    /// BatteryState Notify Changes
    @objc
    private func batteryStateChanged() {
        state.accept(UIDevice.current.batteryState)
    }
}
