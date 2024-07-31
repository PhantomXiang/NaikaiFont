## About
[NaikaiFont by Max](https://github.com/max32002/naikaifont) is a fork from [SetoFont by 瀬戸のぞみ](https://osdn.net/projects/setofont). This font is made for Chinese users and contains over 40k glyphs. All I did was made this into a resource pack, please consider to support the original author if you like it.\
[內海字體](https://github.com/max32002/naikaifont)是基於[瀨戶字體](https://osdn.net/projects/setofont)的開放原始碼中文字型，我只是把它包成資源包而已，如果你喜歡的話請考慮支持一下原作者。

## Versions
There are 3 different versions: **Vanilla**, **Caxton-Raster**, and **Caxton-MSDF**.\
本資源包有三種版本：**Vanilla (原版)**、**Caxton-Raster**，和 **Caxton-MSDF**。
![Comparison 1](https://cdn.modrinth.com/data/EYolFDbG/images/76bf6e89e7bb75bd166cfd78cec8c41c085e8415.png)
- **Vanilla** version doesn't require any mods but looks not ideal. Besides, **bold** texts look weird. Should be able to work on any version after Minecraft 1.13.
- **Caxton-MSDF** version needs [Caxton](https://modrinth.com/mod/caxton) and has basically infinite resolution. However, Caxton's MSDF rendering method doesn't compatible with Iris. In world texts won't be rendered when shaders is on (UI texts aren't affected).
- **Caxton-Raster** version uses Caxton's raster rendering method, the difference between this and vanilla method is Caxton offers blur and mipmap to prevent the aliasings (jagged edges).
</br></br>
- **Vanilla** 版本不需任何模組，但字體的邊緣有惱人的鋸齒；此外，**粗體字**無法正常渲染。1.13以後的版本都支援TTF字體，理論上都能使用。
- **Caxton-MSDF** 版本需要[Caxton](https://modrinth.com/mod/caxton)模組，因為採用了向量圖來渲染，所以不管怎麼放大都不會失真。缺點是開啟Iris光影時，告示牌上的文字無法顯示(UI文字不影響)。
- **Caxton-Raster** 版本是一個折衷的方案，雖然和原版一樣都是用點陣圖渲染，但Caxton提供了模糊效果和mipmap，可以消除礙眼的鋸齒。
![Comparison 2](https://cdn.modrinth.com/data/EYolFDbG/images/acaae3163fe5e64f838e26b5f3deb2d67693fa70.png)
▲ There isn't much difference between **Caxton-Raster** and **Caxton-MSDF** in small texts.\
- ▲ **Caxton-Raster** 和 **Caxton-MSDF** 在較小的文字上幾乎沒有差別。
![Comparison 3](https://cdn.modrinth.com/data/EYolFDbG/images/afa1b69a62e1d70a67398038c0d01f0da630f86c.png)
▲ **Caxton-MSDF** doesn't compatible with Iris.\
▲ **Caxton-MSDF** 和Iris不相容。

## Caxton Configurations
Don't like how the Caxton fonts look or using a different GUI scale? Then you can try to edit the configuration files. I'll show you how.\
不喜歡Caxton的顯示效果嗎？那你可以試試更改字體設定檔，說明如下。

<details>
<summary>For Advanced Users Only 前方高能</summary>
This is basically copy pasted from Caxton's mod page but with some extra explanation.

## assets/minecraft/font/default.json
```json
"blur": true
```
![Config 4](https://cdn.modrinth.com/data/EYolFDbG/images/65a282b3a87c61a61f4fd8502959ccefc328ff9e.png)
Only has an effect on raster tech. If true, texels in the glyph bitmap will be interpolated.

```json
"scale_factor": 1.1,
"shadow_offset": 0.5,
"shift": [0, -0.3]
```
Control the glyph size, shadow size and glyph offset.

```json
"the_font_designer_couldnt_be_assed_to_make_an_italic_variant_so_slant_the_text": 1056964608
```
Automatically generating italic fonts. I think this is a joke made by the author, you need to convert float32 to int32 yourself then Caxton will convert it back (what the heck?). There is a dirty way to get the int number you want via Python:
```python
import struct
# change 0.5 to whatever you want
slant = 0.5 
# the output should be 1056964608
print(struct.unpack('!i', struct.pack('!f', slant))[0])
```

## assets/caxton/textures/font/NaikaiFont-Light.ttf.json and NaikaiFont-Bold.ttf.json
```json
"margin": 4
```
The number of pixels to leave around the glyph bounding box on each side. Should be "range ≤ margin ≤ 255".\
Honestly, I don't even know what it does. I have tried to set it to different numbers, but nothing happened.

```json
"range": 4
```
The width of the range around the glyph between the minimum and maximum representable signed distances. This is a positive integer no greater than 255. This also determines the width of the border drawn for glowing sign text.

```json
"max_mipmap": 2
```
![Config 1](https://cdn.modrinth.com/data/EYolFDbG/images/fe9537120ef5f61191cf7a4a476006239c2f6ede.png)
![Config 2](https://cdn.modrinth.com/data/EYolFDbG/images/b944367f63954374d3d255aed0bedd41819f1c18.png)
The maximum mipmap level (0 – 4). This is pointless to set if you’re using the MSDF rendering tech. However, it can be useful for non-pixel fonts when you’re using the raster rendering tech.\
Higher values mean lower resolution for small texts, which means less aliasings. However, some unwanted artifact may occur. Note there is a strange line under the glyph "一" in the mipmap level 4 picture.

```json
"shrinkage": 16.0
```
![Config 3](https://cdn.modrinth.com/data/EYolFDbG/images/ea70e6afe1398b9f01412ed900466d3794986d03.png)
The number of font units corresponding to each pixel in the texture atlas. This can be set to a high value if using the "msdf" font rendering tech. If you’re using "raster", then you should set this to a lower value.

```json
"tech": "raster"
```
Specifies whether to use the MSDF-based rendering method ("msdf") or to use glyph bitmaps ("raster" – EXPERIMENTAL). "msdf" is recommended for most fonts, but "raster" is more suitable for pixel fonts. In addition, only "raster" is fully compatible with Iris Shaders – text in MSDF fonts will not show up inside the world if a shader is loaded.

</details>

## Download
Visit the [modrinth page](https://modrinth.com/resourcepack/naikai-font) or simply click the "Download ZIP" button.