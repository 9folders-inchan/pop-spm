
MODULE_NAME=$1
BINARY_TARGETS=$2


FORMAT=$(cat <<- EOF
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "${MODULE_NAME}",
    platforms: [
        .iOS(.v9), .macOS(.v10_10)
    ],
    products: [ 
        .library(
            name: "${MODULE_NAME}",
            targets: ["${MODULE_NAME}"]),
    ],
    targets: [
        ${BINARY_TARGETS}
    ]
)
EOF
)

echo "$FORMAT"
