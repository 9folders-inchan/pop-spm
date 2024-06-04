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
            url: "https://github.com/9folders-inchan/pop-spm/releases/download/0.0.2/pop.xcframework.zip",
            checksum: "2d445527839129645b4edb0a4ede5d7d84e47391f2a952c5989e2417648510da" 
        ), 
        .target(
            name: "pop-spm",
            dependencies: ["MaterialComponents", "MDFInternationalization", "MDFTextAccessibility"]
        )
    ]
)
