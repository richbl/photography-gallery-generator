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
#
# Version: 0.2.1
#
# Requirements:
#
#  --A folder full of image files
#  --File for watermark (dbi_watermark.png)
#  --Imagemagick (convert program) for file conversion (size reduction)
#
# Inputs:
#
#  --Gallery name
#  --Output directory to save exported file (absolute path)
#
# Outputs:
#
#  --An exported HTML file if processed successful
#  --If failure, causing error message displayed
#

echo "
|
| A bash script to prep (rename, resize, reduce, and watermark) a folder of
| images, and then generate an index in HTML
|
| Usage:
|   generate_gallery [options]
|
|   -g, --gallery             gallery name
|   -i, --input_dir           absolute directory path to files for parsing
|   -o, --output_dir          absolute directory path for resulting HTML file
|"
echo

# -----------------------------------------------------------------------------
# functions
#
function quit {
  echo
  exit 1
}

function abs_script_dir_path {
    SOURCE=$(if [ -z "${BASH_SOURCE[0]}" ]; then echo $1; else echo ${BASH_SOURCE[0]}; fi)
    while [ -h "$SOURCE" ]; do
      DIR=$( cd -P $( dirname "$SOURCE") && pwd )
      SOURCE=$(readlink "$SOURCE")
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    DIR=$( cd -P $( dirname "$SOURCE" ) && pwd )
    echo $DIR
}

# -----------------------------------------------------------------------------
# global variables
#
DEBUG=false
DIR=$(abs_script_dir_path)

# -----------------------------------------------------------------------------
# check requirements
#
if ! type "convert" &> /dev/null; then
  echo "Error: convert program not installed."
  quit
fi

if [ ! -f ${DIR}/dbi_watermark.png ]; then
   echo "Error: watermark file not found."
   quit
fi

# -----------------------------------------------------------------------------
# scan cmdline for arguments
#
while [[ $# -gt 0 ]]
do
  ARG="$1"

  case $ARG in
   -g|--gallery)
      ARG_GALLERY="$2"
      shift # skip argument
      ;;
   -i|--input_dir)
      ARG_INPUT_DIR="$2"
      shift # skip argument
      ;;
   -o|--output_dir)
      ARG_OUTPUT_DIR="$2"
      shift # skip argument
      ;;
   *)
      # unknown argument
      ;;
  esac
  shift # skip argument or value
done

# -----------------------------------------------------------------------------
# check argument completeness
#
if [ -z "${ARG_GALLERY}" ]; then
  echo "Error: gallery argument (-g|--gallery) missing."
  quit
fi

if [ -z "${ARG_INPUT_DIR}" ]; then
  echo "Error: input_dir argument (-i|--input_dir) missing."
  quit
fi

if [ -z "${ARG_OUTPUT_DIR}" ]; then
  echo "Error: output_dir argument (-o|--output_dir) missing."
  quit
fi

# -----------------------------------------------------------------------------
# copy files to ARG_OUTPUT_DIR
#
echo "Copying source files to destination..."

mkdir -p "${ARG_OUTPUT_DIR}"
cp "${ARG_INPUT_DIR}"/* "${ARG_OUTPUT_DIR}"

echo "Copying source files to destination complete."

# -----------------------------------------------------------------------------
# transpose filenames (lowercase and legal posix name)
#
echo "Transposing filesnames..."

# get directory names
LC_DIRNAME=`echo ${ARG_OUTPUT_DIR} | sed 's/.*/\L&/g'`
POSIX_DIRNAME=`echo ${LC_DIRNAME} | sed 's/[^A-Za-z0-9\-\._\/]/_/g'`

# set filenames to lowercase
find "${ARG_OUTPUT_DIR}" -depth -name "*" -exec basename "{}" \; -execdir rename 'y/A-Z/a-z/' "{}" \; &>/dev/null

# set filenames to legal posix names (A-Z; 0-9), replacing illegal chars with underscore (_)
find "${LC_DIRNAME}" -depth -name "*" -exec basename "{}" \; -execdir rename 's/[^A-Za-z0-9\-\._\/]/_/g' "{}" \; &>/dev/null

# set tmp filename extension
find "${LC_DIRNAME}" -type f -exec mv '{}' '{}'.tmp \; &>/dev/null

echo "Transposing filesnames complete."

# -----------------------------------------------------------------------------
# reducing file sizes
#
echo "Reducing file sizes and applying watermark..."

for file in "${POSIX_DIRNAME}"/*.tmp;
do
   convert $file -quality 50 -auto-orient -resize x1000 ${DIR}/dbi_watermark.png -gravity southeast -geometry +15+15 -composite "${POSIX_DIRNAME}"/reduced\_$(basename ${file%.*})
   rm $file
done

echo "Reducing file sizes and applying watermark complete."

# -----------------------------------------------------------------------------
# generate files list
#
echo "Creating HTML output file..."

# generate results file
echo '<li data-album="'${ARG_GALLERY}'">'${ARG_GALLERY}'</li>' > "${ARG_OUTPUT_DIR}".results
echo >> "${ARG_OUTPUT_DIR}".results
echo '<!-- BEGIN '${ARG_GALLERY}' gallery images -->'>> "${ARG_OUTPUT_DIR}".results

for i in $(find "${POSIX_DIRNAME}" -type f -name '*' -exec basename "{}" \;);
do
    echo '<div class="file" data-type="image" data-source="./images/work/'$(basename ${POSIX_DIRNAME})'/'${i}'" data-caption="" data-album="'${ARG_GALLERY}'"></div>' >> "${ARG_OUTPUT_DIR}".results
done

echo '<!-- END '${ARG_GALLERY}' gallery images -->'>> "${ARG_OUTPUT_DIR}".results

echo "Creating HTML output file complete."

echo
echo "Success. Results file ($(basename ${POSIX_DIRNAME}).results) created in ${ARG_OUTPUT_DIR}."
echo
