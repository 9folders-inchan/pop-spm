// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pop",
    platforms: [
        .iOS(.v9), .macOS(.v10_10)
    ],
    products: [ 
        .library(
            name: "pop",
            targets: ["pop"]),
    ],
    targets: [
        
		.binaryTarget( 
            name: "pop",
            url: "https://github.com/9folders-inchan/pop-spm/releases/download/0.0.2/pop.xcframework.zip",
            checksum: "c230f431a27aee2e7c1da70009126782c6cca1f35252236fe7aa756cfc5aca4c" 
        ), 
    ]
)
