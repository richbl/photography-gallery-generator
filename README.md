##Photography Gallery Generator

This is a simple bash script that parses a folder of images (default: jpg), processes them (reduces, resizes, and applies a watermark) using ImageMagick, and generates an HTML index for use in a photography website.

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
