#!/bin/bash


cwd="$(dirname "${BASH_SOURCE[0]}")"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

RELEASE_VERSION=$1
RELEASE_NOTE=$2

if [[ -z "$RELEASE_VERSION" ]]; then
    RELEASE_VERSION=$(./scripts/bump_version.sh) 
    if [[ -z "$RELEASE_VERSION" ]]; then
    	RELEASE_VERSION="0.0.1"
    fi
fi

set -e

XCFRAMEWORK_NAME="pop-spm"
SCHEME_NAME="pop"

ARCHIVE_PATH="${WORK_DIR}/Archived/${XCFRAMEWORK_NAME}.xcarchive"
ARCHIVE_PATH_Simulator="${WORK_DIR}/Archived/${XCFRAMEWORK_NAME}-Simulator.xcarchive"
FRAMEWORKS_PATH="${ARCHIVE_PATH}/Products/Library/Frameworks"

REPO="$(gh repo view --json owner,name --jq '(.owner.login) + "/" + (.name)')"
REPO_URL="https://github.com/${REPO}"
REPO_XCFRAMEWORK_URL="${REPO_URL}/releases/download/${RELEASE_VERSION}/${XCFRAMEWORK_NAME}.xcframework.zip"

echo "WORK_DIR: ${WORK_DIR}"

# 0. make proj -> PASS
# 1. init cocoapods -> PASS
# 2. clean up
# 3. archive
xcodebuild archive \
	-project "Pods/Pods.xcodeproj" \
	-scheme ${SCHEME_NAME} \
	-archivePath ${ARCHIVE_PATH} \
	-sdk iphoneos \
	SKIP_INSTALL=NO

xcodebuild archive \
	-project "Pods/Pods.xcodeproj" \
	-scheme ${SCHEME_NAME} \
	-archivePath ${ARCHIVE_PATH_Simulator} \
	-sdk iphonesimulator \
	SKIP_INSTALL=NO
# 4. make xcframework
ARTIFACT_PATHS=()
BINARY_TARGETS=()
for framework in $(find ${FRAMEWORKS_PATH} -maxdepth 1 -type d -exec basename {} \; | grep '.framework'); do
	xcframework_name=${framework%.framework}
    xcframework_path="${WORK_DIR}/${xcframework_name}.xcframework"
    xcframework_zip="${xcframework_path}.zip"
	xcodebuild -create-xcframework \
		-framework "${ARCHIVE_PATH}/Products/Library/Frameworks/${xcframework_name}.framework" \
		-framework "${ARCHIVE_PATH_Simulator}/Products/Library/Frameworks/${xcframework_name}.framework" \
		-output "${xcframework_path}"

	# 5. compress
	zip -r -X "${xcframework_zip}" "${xcframework_path}"
	ARTIFACT_PATHS+=("$xcframework_zip")
	checksum="`swift package compute-checksum "$xcframework_zip"`"
	url="${REPO_URL}/releases/download/${RELEASE_VERSION}/${xcframework_name}.xcframework.zip"
  

	BINARY_TARGETS+=$(cat <<EOF

		.binaryTarget( 
            name: "${xcframework_name}",
            url: "${url}",
            checksum: "${checksum}" 
        ), 
EOF
	)
done

# 6 Update package.swift
if [ ! -f Package.swift ]; then
  touch Package.swift
fi
./scripts/format_Package.swift.sh "$SCHEME_NAME" "$BINARY_TARGETS" > Package.swift

# 7. Commit
#git add Package.swift
git add .
git commit -m "New $XCFRAMEWORK_NAME.xcframework version $RELEASE_VERSION"
git tag -m "$RELEASE_NOTE" "$RELEASE_VERSION"
git push origin master

# 8. Release artifact
gh release create "$RELEASE_VERSION" \
  --notes "$RELEASE_NOTE" \
  --repo "$REPO" \
  "${ARTIFACT_PATHS[@]}"

# 9. print
cat <<- EOF
🎉 Release is ready at ${REPO_URL}/releases/tag/${RELEASE_VERSION}
EOF
	
