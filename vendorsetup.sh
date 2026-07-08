FDEVICE="duchamp"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)

    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE=$FDEVICE
    else
        FOX_BUILD_DEVICE=$(get_build_var FOX_BUILD_DEVICE)
    fi
}

fox_get_target_device

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
    export FOX_BUILD_DEVICE=duchamp
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export OF_DEFAULT_KEYMASTER_VERSION=4.1
    export OF_FORCE_PREBUILT_KERNEL=1
fi