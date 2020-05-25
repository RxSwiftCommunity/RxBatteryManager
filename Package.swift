// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxBatteryManager",
    products: [
        .library(name: "RxBatteryManager", targets: ["RxBatteryManager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1")
    ],
    targets: [
        .target(name: "RxBatteryManager", dependencies: ["RxSwift", "RxCocoa"], path: "Sources")
    ]
)
