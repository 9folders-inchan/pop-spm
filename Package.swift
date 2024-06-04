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
            url: "https://github.com/9folders-inchan/pop-spm/releases/download/0.0.3/pop.xcframework.zip",
            checksum: "933dc35d4837e6cd478b6859d1c2fddf1933fd205fcb19e324953ee4a21beaff" 
        ), 
    ]
)
