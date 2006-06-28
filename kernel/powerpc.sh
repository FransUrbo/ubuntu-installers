arch_get_kernel_flavour () {
	CPU=`grep '^cpu[[:space:]]*:' "$CPUINFO" | head -n1 | cut -d: -f2 | sed 's/^ *//; s/[, ].*//' | tr A-Z a-z`
	case "$CPU" in
		power3|i-star|s-star)
			family=powerpc64
			;;
		power4|power4+|ppc970|ppc970fx)
			family=powerpc64
			;;
		*)
			family=powerpc
			;;
	esac
	case "$SUBARCH" in
		powermac*|prep|chrp*)	echo "$family" ;;
		amiga)			echo apus ;;
		*)
			warning "Unknown $ARCH subarchitecture '$SUBARCH'."
			return 1
		;;
	esac
	return 0
}

arch_check_usable_kernel () {
	# CPU family must match exactly.
	if expr "$1" : ".*-$2.*" >/dev/null; then return 0; fi
	return 1
}

arch_get_kernel () {
	CPUS="$(grep -ci ^processor "$CPUINFO")" || CPUS=1
	case $1 in
		powerpc64)
			SMP=-smp
			;;
		*)
			if [ "$CPUS" ] && [ "$CPUS" -gt 1 ]; then
				SMP=-smp
			else
				SMP=
			fi
	esac

	echo "linux-$1$SMP"
}
