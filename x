#!/bin/sh
set -e
xbps-install -S
xbps-install --yes xorg-server xorg-minimal xinit
for GPU in $(lspci | grep -E "VGA|3D" | awk '{print $5}' | sort -u); do
	case "$GPU" in
	Intel*)
		xbps-install --yes xf86-video-intel
		;;
	AMD*)
		xbps-install --yes xf86-video-amdgpu xf86-video-ati
		;;
	NVIDIA*)
		xbps-install --yes xf86-video-nouveau
		;;
	*)
		xbps-install --yes xf86-video-vesa
		;;
	esac
done
