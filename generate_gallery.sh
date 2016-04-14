#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (C) Business Learning Incorporated (businesslearninginc.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.
# -----------------------------------------------------------------------------
#
# A bash script to prep (rename, resize, reduce, and watermark) a folder of
# images, and then generate an index in HTML
# version: 0.4.0
#
# requirements:
#  --A folder full of image files
#  --File for watermark
#  --Imagemagick (convert program) for file conversion (size reduction)
#
# inputs:
#  --Gallery name
#  --Output directory to save exported file (absolute path)
#
# outputs:
#  --An exported HTML file if processed successful
#  --If failure, causing error message displayed
#

# -----------------------------------------------------------------------------
# script configuration
#
shopt -s extglob
EXEC_DIR="$(dirname "$0")"
. ${EXEC_DIR}/lib/args
. ${EXEC_DIR}/lib/general

ARGS_FILE="${EXEC_DIR}/data/config.json"

declare -a REQ_PROGRAMS=('jq' 'convert')
declare -a REQ_FILES='('"${EXEC_DIR}"'/dbi_watermark.png)'

# -----------------------------------------------------------------------------
# perform script configuration, arguments parsing, and validation
#
check_program_dependencies "REQ_PROGRAMS[@]"
check_file_dependencies "REQ_FILES[@]"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# copy files to output_dir
#
echo "Copying source files to destination..."

mkdir -p "$(get_config_arg_value output_dir)"
cp "$(get_config_arg_value input_dir)"/* "$(get_config_arg_value output_dir)"

echo "Copying source files to destination complete."
echo

# -----------------------------------------------------------------------------
# transpose filenames (lowercase and legal posix name)
#
echo "Transposing filesnames..."

# get directory names
LC_DIRNAME=`echo $(get_config_arg_value output_dir) | sed 's/.*/\L&/g'`
POSIX_DIRNAME=`echo ${LC_DIRNAME} | sed 's/[^A-Za-z0-9\-\._\/]/_/g'`

# set filenames to lowercase
find "$(get_config_arg_value output_dir)" -depth -name "*" -exec basename "{}" \; -execdir rename 'y/A-Z/a-z/' "{}" \; &>/dev/null

# set filenames to legal posix names (A-Z; 0-9), replacing illegal chars with underscore (_)
find "${LC_DIRNAME}" -depth -name "*" -exec basename "{}" \; -execdir rename 's/[^A-Za-z0-9\-\._\/]/_/g' "{}" \; &>/dev/null

# set tmp filename extension
find "${LC_DIRNAME}" -type f -exec mv '{}' '{}'.tmp \; &>/dev/null

echo "Transposing filesnames complete."
echo

# -----------------------------------------------------------------------------
# reducing file sizes
#
echo "Reducing file sizes and applying watermark..."

for file in "${POSIX_DIRNAME}"/*.tmp; do
  convert $file -quality 50 -auto-orient -resize x1000 ${EXEC_DIR}/dbi_watermark.png -gravity southeast -geometry +15+15 -composite "${POSIX_DIRNAME}"/reduced\_$(basename ${file%.*})
  rm $file
done

echo "Reducing file sizes and applying watermark complete."
echo

# -----------------------------------------------------------------------------
# generate files list (HTML)
#
echo "Creating HTML output file..."

# generate results file (sorted)
TMPFILE=$(mktemp);

for i in $(find "${POSIX_DIRNAME}" -type f -name '*' -exec basename "{}" \;); do
  echo '<div class="file" data-type="image" data-source="./images/work/'$(basename ${POSIX_DIRNAME})'/'${i}'" data-caption="" data-album="'$(get_config_arg_value gallery)'"></div>' >> ${TMPFILE}
done

# sort content
sort ${TMPFILE} -o "$(get_config_arg_value output_dir)".results

# generate results file
LINE="<li data-album=$(get_config_arg_value gallery)>$(get_config_arg_value gallery)</li>

<!-- BEGIN $(get_config_arg_value gallery) gallery images -->"

echo "${LINE}" | cat - "$(get_config_arg_value output_dir)".results > ${TMPFILE} && mv ${TMPFILE} "$(get_config_arg_value output_dir)".results
echo '<!-- END '$(get_config_arg_value gallery)' gallery images -->'>> "$(get_config_arg_value output_dir)".results

echo "Creating HTML output file complete."

echo
echo "Success. Results file ($(basename ${POSIX_DIRNAME}).results) created in $(get_config_arg_value output_dir)."
echo
