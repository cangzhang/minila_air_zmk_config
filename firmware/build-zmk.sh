#!/usr/bin/env bash
#

l=$PWD
zmk_folder="$HOME/lavello/zmk/app"
zmk_config="$HOME/playground/keyboard/mlego-zmk/config/"
zmk_extra="$HOME/lavello/zmk-helpers"
pushd $zmk_folder

shield="mlego_m66_rev4"
board="nice_nano_v2"
build_folder="mlego_m66_rev4"

rm -rf "$build_folder"

west build -d "$build_folder" -p always -b $board -S studio-rpc-usb-uart -- -DSHIELD="$shield" -DZMK_CONFIG=$zmk_config -DZMK_EXTRA_MODULES=$zmk_extra -DCONFIG_ZMK_STUDIO=y
[[ -f "$build_folder/zephyr/zmk.uf2" ]] && cp "$build_folder/zephyr/zmk.uf2" "$l/$build_folder.uf2"

while [ ! -d /run/media/drFaustroll/NICENANO/ ]; do
  sleep 1
  echo -n "."
done

echo "done"

set -x

cp "$l/$build_folder.uf2" /run/media/drFaustroll/NICENANO/
