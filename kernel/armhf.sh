arch_get_kernel_flavour () {
	case "$SUBARCH" in
	    generic-lpae|generic|keystone|omap|omap4|versatile|mx5)
		echo "$SUBARCH"
		return 0 ;;
	    *)
		warning "Unknown $ARCH subarchitecture '$SUBARCH'."
		return 1 ;;
	esac
}

arch_check_usable_kernel () {
	# Subarchitecture must match exactly
	if echo "$1" | grep -Eq -- "-$2(-.*)?$"; then return 0; fi
	return 1
}

arch_get_kernel () {
	echo "linux-$1"
	echo "linux-image-$1"
}
