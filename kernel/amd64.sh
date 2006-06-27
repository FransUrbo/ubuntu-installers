arch_get_kernel_flavour () {
	VENDOR=`grep '^vendor_id' /proc/cpuinfo | cut -d: -f2`
	case "$VENDOR" in
		" AuthenticAMD"*)	echo amd64-k8 ;;
		" GenuineIntel"*)	echo em64t-p4 ;;
		*)			echo amd64-generic ;;
	esac
	return 0
}

arch_check_usable_kernel () {
	# Generic kernels can be run on any machine.
	if expr "$1" : '.*-amd64-generic.*' >/dev/null; then return 0; fi

	# K8 and P4 kernels require that machine.
	case "$2" in
		amd64-k8)
			if expr "$1" : '.*-amd64-k8.*' >/dev/null; then
				return 0
			fi
			;;
		em64t-p4)
			if expr "$1" : '.*-em64t-p4.*' >/dev/null; then
				return 0
			fi
			;;
	esac

	return 1
}

arch_get_kernel () {
	if dmesg | grep -q "WARNING: NR_CPUS limit of 1 reached."; then
		SMP=-smp
	else
		SMP=
	fi
	case "$1" in
		amd64-k8)
			echo "linux-amd64-k8$SMP"
			;;
		em64t-p4)
			echo "linux-amd64-xeon"
			;;
		*)
			echo "linux-amd64-generic"
			;;
	esac
}
