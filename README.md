## Photography Gallery Generator
This is a simple [BaT](https://github.com/richbl/a-bash-template) bash script that:

- Parses a folder of images (default: jpg)
- Processes these image files (reduces, resizes, and applies a watermark) using ImageMagick
- Generates an HTML index for use in a photography website

## [<img src="https://cloud.githubusercontent.com/assets/10182110/18208786/ae5d76b2-70e5-11e6-9663-cfe47d13f4d9.png" width="150" />](https://github.com/richbl/a-bash-template)Developed with a Bash Template (BaT)

This [bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) script uses a bash template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [sshpass](http://linux.die.net/man/1/sshpass) and [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-u|--username`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT project here](https://github.com/richbl/a-bash-template).

## Example
See below for an example of both a processed image file and the resulting HTML index:

![Sample Output from generate_gallery with Watermark](https://cloud.githubusercontent.com/assets/10182110/11600178/e89555b2-9a7f-11e5-8d9a-888f57f62035.jpg "Sample Output from generate_gallery with Watermark")


```
<!-- BEGIN Macro World gallery images -->
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_4208.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_9084.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_4732.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_3318.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp6631.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp2292.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_4988.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_3408__2_.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_1022.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_1462.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp0534.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp0042.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_3644.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_img_2855.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp3321_3.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_bbg.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_download003.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp1565.jpg" data-caption="" data-album="Macro World"></div>
<div class="file" data-type="image" data-source="./images/work/macro_world/reduced_imgp5595.jpg" data-caption="" data-album="Macro World"></div>
<!-- END Macro World gallery images -->
```
## A Note on Cloning: This Project Uses Git Submodules
This project uses a Git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) project, specifically the `bash-lib` folder to keep the **A-Bash-Template** project up-to-date without manual intervention.

So, be sure to clone this project with the `--recursive` switch (`git clone --recursive https://github.com/richbl/a-bash-template`) so any submodule project(s) will be automatically cloned as well. If you clone into this project without this switch, you'll likely see empty submodule project folders (depending on your version of Git).
