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
            url: "https://github.com/9folders-inchan/pop-spm/releases/download//pop.xcframework.zip",
            checksum: "1711dcc0f36c3fcf1b77d7fe472d309912eda8f6d326d579e20156c29601a50a" 
        ), 
        .target(
            name: "pop-spm",
            dependencies: ["MaterialComponents", "MDFInternationalization", "MDFTextAccessibility"]
        )
    ]
)
