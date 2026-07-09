DEVICE_PATH := device/xiaomi/duchamp

# ==========================================
# CÁC LỆNH "LÁCH LUẬT" BUILD
# ==========================================
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# ==========================================
# THÔNG SỐ PHIÊN BẢN (CẬP NHẬT ANDROID 16)
# ==========================================
PLATFORM_VERSION := 16
PLATFORM_VERSION_LAST_STABLE := 16
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ==========================================
# KIẾN TRÚC CPU
# ==========================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_IS_64_BIT := true
TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# ==========================================
# NỀN TẢNG & PHẦN CỨNG MTK
# ==========================================
TARGET_OTA_ASSERT_DEVICE := duchamp
TARGET_BOARD_PLATFORM := mt6897
PRODUCT_PLATFORM := mt6897

BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
MTK_HARDWARE := true

# ==========================================
# BOOTLOADER & KERNEL (VENDOR_BOOT)
# ==========================================
TARGET_NO_KERNEL := true
BOARD_USES_VENDOR_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# Định dạng nén ramdisk
BOARD_RAMDISK_USE_LZ4 := true
BOARD_VENDOR_BOOTIMAGE_FILE_SYSTEM_TYPE := lz4

# Thông số bộ nhớ (Lấy từ ROM stock)
BOARD_PAGE_SIZE := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_OFFSET := 0x40000000
BOARD_RAMDISK_OFFSET := 0x66f00000
BOARD_TAGS_OFFSET := 0x47c80000
BOARD_DTB_OFFSET := 0x47c80000

BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2

BOARD_MKBOOTIMG_ARGS += --vendor_cmdline "$(BOARD_VENDOR_CMDLINE)"
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# DTB Prebuilt
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# ==========================================
# PHÂN VÙNG DYNAMIC (ĐÃ THÊM SYSTEM_DLKM)
# ==========================================
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 9122611200
BOARD_MAIN_PARTITION_LIST := system system_ext vendor product odm vendor_dlkm odm_dlkm system_dlkm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# ==========================================
# BẢO MẬT AVB (QUAN TRỌNG ĐỂ KHÔNG BOOTLOOP)
# ==========================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# ==========================================
# RECOVERY (ORANGEFOX / TWRP)
# ==========================================
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Fastbootd (Bắt buộc cho máy hiện đại)
TW_INCLUDE_FASTBOOTD := true

# Giao diện & Tính năng cơ bản
TW_FRAMERATE := 60
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_EXCLUDE_DEFAULT_USB_INIT := true

TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true

# Độ sáng
TW_DEFAULT_BRIGHTNESS := 400
TW_MAX_BRIGHTNESS := 2047
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TARGET_SCREEN_WIDTH := 1220
TARGET_SCREEN_HEIGHT := 2712

# Loại trừ phần không cần thiết để tránh tràn phân vùng
TW_EXCLUDE_APEX := true
TW_EXCLUDE_PYTHON := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_TZDATA := true
TW_EXCLUDE_BASH := true

# Driver / Mô-đun nhân
TW_LOAD_VENDOR_BOOT_MODULES := true
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := true
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recovery/root/lib/modules/*.ko)

# ==========================================
# CHÍNH THỨC BẬT GIẢI MÃ BỘ NHỚ (DECRYPTION)
# ==========================================
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_ENCRYPTION := true

# Gọi các file prop mở rộng
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop