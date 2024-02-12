read -p "Enter name of language package you want to update (typescript/python/go/java): " LANGUAGE

if [ "$LANGUAGE" != "typescript" ] && [ "$LANGUAGE" != "python" ] && [ "$LANGUAGE" != "go" ] && [ "$LANGUAGE" != "java" ]; then
    echo "Error: Invalid language. Please enter either 'typescript' or 'python'."
    exit 1
fi

PACKAGE="cdk8s-cmp-$LANGUAGE"

LATEST_VERSION_RAW=$(git tag -l "$PACKAGE/v*" | cat | sort -rV | head -n 1)

LATEST_VERSION="0.0"

if [[ $LATEST_VERSION_RAW =~ $PACKAGE/v(.*) ]]; then
    LATEST_VERSION="${BASH_REMATCH[1]}"
fi

read -p "Enter new version in format of <major>.<minor> (Latest version is $LATEST_VERSION): " VERSION_BUMP

if [[ $VERSION_BUMP =~ ^[0-9]+(\.[0-9]+)$ ]]; then
    NEW_VERSION_TAG_NAME="$PACKAGE/v$VERSION_BUMP"

    if git rev-parse "$NEW_VERSION_TAG_NAME" >/dev/null 2>&1; then
        echo "Tag $NEW_VERSION_TAG_NAME already exists.\n\ngit tag -d $NEW_VERSION_TAG_NAME"
        exit 1
    fi

    CHANGELOG="## $VERSION_BUMP\n - TODO"

    CHANGELOG_FILE="./$LANGUAGE/CHANGELOG.md"

    touch "$CHANGELOG_FILE"

    echo "$CHANGELOG$(cat "$CHANGELOG_FILE")" > "$CHANGELOG_FILE"

    echo "\nChangelog entry created at $CHANGELOG_FILE. Please update it before release."

    git tag $NEW_VERSION_TAG_NAME

    echo "New tag named $NEW_VERSION_TAG_NAME created.\n"

    echo "run:\ngit push origin $NEW_VERSION_TAG_NAME"
else
    echo "Invalid version, please follow SemVer format <major>.<minor>"
    exit 1
fi
