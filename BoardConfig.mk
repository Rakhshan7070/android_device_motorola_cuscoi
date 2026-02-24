#
# Copyright (C) 2025 The LineageOS Project
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

DEVICE_PATH := device/motorola/cuscoi

# Inherit from motorola sm7435-common
include device/motorola/sm7435-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := cuscoi

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-parrot-cuscoi.config

# Manifest
ODM_MANIFEST_SKUS += b d
ODM_MANIFEST_B_FILES := $(DEVICE_PATH)/sku/manifest_b.xml $(COMMON_PATH)/vintf/manifest_ss.xml
ODM_MANIFEST_D_FILES := $(DEVICE_PATH)/sku/manifest_d.xml

# Partitions
BOARD_MOT_DP_GROUP_SIZE := 8313110528 # (BOARD_SUPER_PARTITION_SIZE - 4MB)
BOARD_SUPER_PARTITION_SIZE := 8317304832

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/configs/properties/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/properties/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
BOOT_SECURITY_PATCH := 2025-05-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ROLLBACK_INDEX := 13
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 13

# inherit from the proprietary version
include vendor/motorola/cuscoi/BoardConfigVendor.mk
