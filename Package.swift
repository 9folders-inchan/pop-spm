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
            checksum: "2013c66a3ca470be9a635228cc9b8e8d059d7d754002b815ee444dd48b93b408" 
        ), 
    ]
)
