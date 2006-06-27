arch_get_kernel_flavour () {
	CPU=`grep '^cpu[[:space:]]*:' /proc/cpuinfo | cut -d: -f2 | sed 's/^ *//; s/[, ].*//' | tr A-Z a-z`
	case "$CPU" in
		power3|i-star|s-star)
			family=power3
			;;
		power4|ppc970)
			family=power4
			;;
		*)
			family=powerpc
			;;
	esac
	case "$SUBARCH" in
		powermac_newworld)	echo "$family-pmac" ;;
		powermac_oldworld)	echo "$family-pmac" ;;
		prep)			echo "$family-prep" ;;
		chrp*)			echo "$family-chrp" ;;
		amiga)			echo apus ;;
		*)
			warning "Unknown $ARCH subarchitecture '$SUBARCH'."
			return 1
		;;
	esac
	return 0
}

arch_check_usable_kernel () {
	# CPU family and subarchitecture must match exactly.
	family="${2%%-*}"
	if ! expr "$1" : ".*-$family.*" >/dev/null; then return 1; fi
	# 2.6 kernels (including all "linux-*" kernels) don't differ by
	# subarchitecture.
	if expr "$1" : ".*-2\.6.*" >/dev/null || \
	   expr "$1" : "linux-.*" >/dev/null; then
		return 0
	fi
	subarch="${2#*-}"
	if expr "$1" : ".*-$subarch.*" >/dev/null; then return 0; fi
	return 1
}

arch_get_kernel () {
	family="${1%%-*}"
	echo "linux-$family"
}
