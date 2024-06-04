// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pop-spm",
    platforms: [
        .iOS(.v9), .macOS(.v10_10)
    ],
    products: [ 
        .library(
            name: "pop-spm",
            targets: ["pop-spm"]),
    ],
    targets: [
        
		.binaryTarget( 
            name: "pop",
            url: "https://github.com/9folders-inchan/pop-spm/releases/download/0.0.1/pop.xcframework.zip",
            checksum: "412e3a240b5b55f2a678471c3b623b472a65f1c36fffa4777cdd0899724ce967" 
        ), 
        .target(
            name: "pop-spm",
            dependencies: ["MaterialComponents", "MDFInternationalization", "MDFTextAccessibility"]
        )
    ]
)
