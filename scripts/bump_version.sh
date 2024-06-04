LAST_VERSION=$1

REPO="$(gh repo view --json owner,name --jq '(.owner.login) + "/" + (.name)')"

if [[ -z "$LAST_VERSION" ]]; then
    LAST_VERSION="$(gh api repos/${REPO}/releases/latest --cache 600s  --jq '.tag_name')"
fi

IFS='.' read -ra VERS <<< "$LAST_VERSION"
MAJOR="${VERS[0]:-0}"
MINOR="${VERS[1]:-0}"
PATCH="${VERS[2]:-0}"
NEW_VERSION="${MAJOR}.${MINOR}.$((PATCH + 1))"
echo "$NEW_VERSION"
