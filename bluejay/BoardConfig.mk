#
# Copyright (C) 2020 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifdef PHONE_CAR_BOARD_PRODUCT
    include device/google_car/$(PHONE_CAR_BOARD_PRODUCT)/BoardConfig.mk
else
    TARGET_SCREEN_DENSITY := 420
endif

RELEASE_GOOGLE_PRODUCT_RADIO_DIR := $(RELEASE_GOOGLE_BLUEJAY_RADIO_DIR)
RELEASE_GOOGLE_BOOTLOADER_BLUEJAY_DIR ?= pdk# Keep this for pdk TODO: b/327119000
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_BLUEJAY_DIR)
$(call soong_config_set,bluejay_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_BLUEJAY_DIR))

# Enable load module in parallel
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

# The modules which need to be loaded in sequential
BOARD_KERNEL_CMDLINE += fips140.load_sequential=1
BOARD_KERNEL_CMDLINE += exynos_mfc.load_sequential=1
BOARD_KERNEL_CMDLINE += exynos_drm.load_sequential=1
BOARD_KERNEL_CMDLINE += pcie-exynos-core.load_sequential=1
BOARD_KERNEL_CMDLINE += g2d.load_sequential=1

TARGET_BOARD_INFO_FILE := device/google/bluejay/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := bluejay
USES_DEVICE_GOOGLE_BLUEJAY := true
BOARD_KERNEL_CMDLINE += disable_dma32=on

include device/google/gs101/BoardConfig-common.mk
include device/google/gs101/wifi/BoardConfig-wifi.mk
include device/google/gs-common/check_current_prebuilt/check_current_prebuilt.mk

$(call soong_config_set,google3a_config,target_device,bluejay)

DEVICE_PATH := device/google/bluejay
VENDOR_PATH := vendor/google/bluejay
include $(DEVICE_PATH)/$(TARGET_BOOTLOADER_BOARD_NAME)/BoardConfigLineage.mk
include $(DEVICE_PATH)/$(TARGET_BOOTLOADER_BOARD_NAME)/BoardConfigEvolution.mk

# TWRP Configuration (dodaj na koniec istniejącego pliku)
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_HAS_DOWNLOAD_MODE := true
TW_NO_LEGACY_PROPS := true
TW_USE_NEW_MINADBD := true
TW_INCLUDE_NTFS_3G := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Encryption
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# For Android 16 compatibility
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0
