# A Reactive BatteryManager in Swift

[![Build Status](https://travis-ci.com/mustafagunes/RxBatteryManager.svg?branch=master)](https://github.com/mustafagunes/RxBatteryManager)
[![Swift](https://img.shields.io/badge/swift-5.1-orange.svg)](https://github.com/mustafagunes/RxBatteryManager)
[![RxSwift](https://img.shields.io/badge/RxSwift-5.1.1-red.svg)](https://github.com/ReactiveX/RxSwift)
[![SPM Compatible](https://img.shields.io/badge/SPM-1.0.3-brightgreen.svg)](https://swift.org/package-manager)
[![CocoaPods Compatible](https://img.shields.io/badge/Cocoapod-1.0.3-brightgreen.svg)](https://cocoapods.org)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-not%20supported-lightgrey.svg)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/badge/Platform-%20iOS-lightgrey.svg)](https://github.com/mustafagunes/RxBatteryManager)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/mustafagunes/RxBatteryManager/blob/master/LICENSE)

## Motivation
I needed a battery manager when developing my apps with Rx. And I started to write the manager. With the battery manager, you can stream data from your battery in a reactive manner. For example, by subscribing to the critical battery status of your battery, you can improve the user experience and reduce battery usage by changing the dark/light modes of your application. I wanted to share this library I developed with the community. My biggest motivation was that the community was very helpful and friendly. I hope useful.

## 🛠 Requirements
* iOS 9.0+
* Xcode 11+
* Swift 5.1+
* RxSwift 5.1.1+

## ⚙️ Installation

### Swift Package Manager (requires Xcode 11)
Add package into Project settings -> Swift Packages

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)
Add RxBatteryManager dependency to your Podfile
```
# Podfile
use_frameworks!

# replace YOUR_TARGET_NAME with yours
target 'YOUR_TARGET_NAME' do
    pod 'RxBatteryManager',    '~> 1.0'
end
```
and run 
```
$ pod install
```

## 👨‍💻 Usage
```swift
import RxBatteryManager
```

#### Singleton RxBatteryManager
```swift
let battery = Battery.monitor
```

#### Init Library in AppDelegate
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    // Monitoring Battery
    Battery.monitor.start()
    
    return true
}
```

#### *level* - float returns
```swift
battery.level
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { [weak self] level in
        guard let self = self else { return }
        print(level)
    }).disposed(by: disposeBag)
```

#### *state* - UIDevice.Enum returns in BatteryState type
```swift
battery.state
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .unknown:
            print("unknown")
        case .unplugged:
            print("unplugged")
        case .charging:
            print("charging")
        case .full:
            print("full")
        @unknown default:
            fatalError()
        }
    }).disposed(by: disposeBag)
```

#### *isLowPowerMode* - bool returns
```swift
battery.isLowPowerMode
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { [weak self] isLowPowerMode in
        guard let self = self else { return }
        print(isLowPowerMode)
    }).disposed(by: disposeBag)
```

#### *isLowLevel* - bool returns
```swift
battery.isLowLevel
    .observeOn(MainScheduler.instance)
    .distinctUntilChanged()
    .subscribe(onNext: { [weak self] isLowLevel in
        guard let self = self else { return }
        self.isLowBatteryLabel.text = "\(isLowLevel)"
    }).disposed(by: disposeBag)
```

#### *isCriticalLevel* - bool returns
```swift
battery.isCriticalLevel
    .observeOn(MainScheduler.instance)
    .distinctUntilChanged()
    .subscribe(onNext: { [weak self] isCriticalLevel in
        guard let self = self else { return }
        self.isCriticalBatteryLabel.text = "\(isCriticalLevel)"
    }).disposed(by: disposeBag)
```

**Note: I recommend you subscribe to Main Thread**

## 👮‍♂️License

RxBatteryManager is available under the [MIT](https://github.com/mustafagunes/RxBatteryManager/blob/master/LICENSE) license. See the LICENSE file for more info.
Copyright (c) Mustafa GUNES
