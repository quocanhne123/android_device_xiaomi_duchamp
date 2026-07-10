#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from duchamp device
$(call inherit-product, device/xiaomi/duchamp/device.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_DEVICE := duchamp
PRODUCT_NAME := twrp_duchamp
PRODUCT_BRAND := POCO
PRODUCT_MODEL := 2311DRK48G
PRODUCT_MANUFACTURER := xiaomi

# Hide Reflash TWRP & FUSE passthrough
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true
# =========================================================
# ÉP GIẢM CÂN ORANGEFOX (BẮT BUỘC ĐỂ TRONG FILE PRODUCT MK)
# =========================================================
TW_ONLY_ENGLISH := true
TW_EXTRA_LANGUAGES := false

FOX_EXCLUDE_THEMES := true
FOX_EXCLUDE_GREY_THEME := true
FOX_BUGGED_THEMES := true

TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_PYTHON := true
FOX_USE_BASH := false
FOX_USE_NANO := false
FOX_USE_TAR := false
FOX_REMOVE_AAPT := true
FOX_DISABLE_APP_MANAGER := true
    
