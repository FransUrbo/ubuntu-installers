arch_get_kernel_flavour () {
	VENDOR=`grep '^vendor_id' "$CPUINFO" | cut -d: -f2`
	FAMILY=`grep '^cpu family' "$CPUINFO" | cut -d: -f2`
	case "$VENDOR" in
		" AuthenticAMD"*)
			case "$FAMILY" in
				" 6")	echo k7 ;;
				" 5")	echo k6 ;;
				*)	echo 386 ;;
			esac
		;;
		" GenuineIntel"|" GenuineTMx86"*)
			case "$FAMILY" in
				" 6"|" 15")	echo 686 ;;
				" 5")		echo 586tsc ;;
				*)		echo 386 ;;
			esac
		;;
		*) echo 386 ;;
	esac
	return 0
}

arch_check_usable_kernel () {
	if expr "$1" : '.*-386.*' >/dev/null; then return 0; fi
	if [ "$2" = 386 ]; then return 1; fi
	if expr "$1" : '.*-586.*' >/dev/null; then return 0; fi
	if [ "$2" = 586tsc ]; then return 1; fi
	if [ "$2" = 686 ]; then
		if expr "$1" : '.*-686.*' >/dev/null; then return 0; fi
		return 1
	fi
	if expr "$1" : '.*-k6.*' >/dev/null; then return 0; fi
	if [ "$2" = k6 ]; then return 1; fi
	if expr "$1" : '.*-k7.*' >/dev/null; then return 0; fi

	# default to usable in case of strangeness
	warning "Unknown kernel usability: $1 / $2"
	return 0
}

arch_get_kernel () {
	if [ -n "$NUMCPUS" ] && [ "$NUMCPUS" -gt 1 ]; then
		SMP=-smp
	else
		SMP=
	fi

	if [ "$KERNEL_MAJOR" = 2.4 ]; then
		imgbase="kernel-image-$KERNEL_MAJOR"
	else
		imgbase=linux
	fi
	if [ "$1" = k7 ]; then
		if [ "$SMP" ]; then
			echo "$imgbase-k7$SMP"
		fi
		echo "$imgbase-k7"
		set k6
	fi
	if [ "$1" = k6 ]; then
		if [ "$KERNEL_MAJOR" = 2.4 ]; then
			echo "$imgbase-k6"
		fi
		set 586tsc
	fi
	if [ "$1" = 686 ]; then
		if [ "$SMP" ]; then
			echo "$imgbase-686$SMP"
		fi
		echo "$imgbase-686"
		set 586tsc
	fi
	if [ "$1" = 586tsc ]; then
		if [ "$KERNEL_MAJOR" = 2.4 ]; then
			echo "$imgbase-586tsc"
		fi
		set 386
	fi
	echo "$imgbase-386"
}
