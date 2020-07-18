################################################################################
#
# init-rootfs-rotate
#
################################################################################

LINUX_EXTENSIONS += init-rootfs-rotate

INIT_ROOTFS_ROTATE_INITRAMFS = $(LINUX_DIR)/custom-initramfs.cpio

define INIT_ROOTFS_ROTATE_PREPARE_KERNEL
	$(INIT_ROOTFS_ROTATE_KERNEL_PREPARE_CMDS)
	$(INIT_ROOTFS_ROTATE_KERNEL_BUILD_CMDS)
endef
