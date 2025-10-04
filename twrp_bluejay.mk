# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from bluejay device
$(call inherit-product, device/google/bluejay/device.mk)

# Inherit TWRP config
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier
PRODUCT_DEVICE := bluejay
PRODUCT_NAME := twrp_bluejay
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 6a
PRODUCT_MANUFACTURER := Google

# TWRP specific build flags
PRODUCT_USE_DYNAMIC_PARTITIONS := true
