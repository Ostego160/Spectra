# Spectra
Spectra Color Manager for LOVE2D


## Description:

The Spectra Color Manager for LOVE2D stores a palette, RGB clamp values, and color mixing functions.  It was created to store color values and to create a gradient effects, especially tiled grids and cooresponding color values.

## Usage:

### Initialization

Spectra is used by first requiring it, then initializing with the default palette by calling the Spectra with no arguments.
```
Spectra = require('spectra')

spectra = Spectra()
```
This will initialize Spectra with the default palette of approximately 64 colors.  Custom palettes can be used in the following form:
```
customPalette = {}
customPalette['myBlue'] = {0,32,255}
customPalette['myGreen'] = {0,255,64}

spectra = Spectra(customerPalette)
```


### Get
```
function Spectra:get(color, alpha)
```
Colors can be retrieved by calling them using the <b>get</b> function.  The first argument is the name of color as a string.  The second, optional argument is the alpha value to be passed through.
#### Example
```
--Blue without alpha channel
love.graphics.setColor( spectra:get('blue') )

--Blue with alpha channel
love.graphics.setColor( spectra:get('blue', 128) )
```

### Edit
```
function Spectra:edit(color, r,g,b)
```
Colors can be modified or created using the <b>edit</b> function.  The named color is passed as the first argument as a string.  The following three arguments are the respective RGB values for the edit.

#### Example
```
spectra:edit('myColor', 255,255,255)
--myColor has been added to the palette

spectra:edit('gray', 100,100,100)
--gray already exists so its RGB values are changed
```
Colors are stored in the palette as named strings as indices.  

### ColorCount
The <b>colorCount</b> function can be used to return the total amount of stored colors in the palette.
#### Example
```
numberOfColors = spectra:colorCount()
```

### Mix
```
function Spectra:mix(color,alpha,shade, color2,factor)
```
The <b>mix</b> function combines two colors by a factor 0-1 as well as applying alpha and lighten/darken effects. The first three arguments indicate initial color, alpha, and a shade value.  The shade value default is 255; increasing or decreasing this value brightens or darkens the color respectively.  Note: A shade value of 0 is black however, a high shade value does not mean the color becomes white, it becomes brighter.

The second color is optional, however it will combine with the first by a factor of 0-1 (A value of .5 means exactly halfway between the colors.)
#### Example
```
love.graphics.setColor( spectra:mix('lightblue',128,255) )
--The color has been set to light blue with half opacity

love.graphics.setColor ( spectra:mix('purple', 255, 300, 'green', .5) )
--The color has been set to a purple/green mix with increased brightness
```

### Gradient
```
function Spectra:gradient(range, distance, colorTable)
```
The <b>gradient</b> function combines 2-4 colors based on a range and distance.  The colorTable argument accepts a table with named colors, as well as alpha and shade fields.
#### Example
```
love.graphics.setColor( spectra:gradient(512, 256, {'aqua','blue','midnight','black'}))
--The color has been set to midway between 'blue' and 'midnight' in the gradient

love.graphics.setColor( spectra:gradient(256, 256, {'red','blue', alpha=128, shade=128}))
--The color has been set to full 'blue' because the distance has reached the range.  
--The color is half opacity and half darkened.
```

### Clamp
```
function Spectra:clamp(minColor,minFactor, maxColor,maxFactor)
```
The clamp function modifies the Spectra object minimum and maximum RGB values.  Once a clamp has been set it affects the mix and gradient functions; get is not affected by clamp.  The minFactor and maxFactor are values between 0-1 and calling clamp with no arguments resets the min and max.
#### Example
```
spectra:clamp('blue',.25, 'white', 1)
--The minimum RGB values have been shifted toward 'blue' by 25% while the 
--maximum remains unchanged (100% white is default)
spectra:clamp()
--The min and max limits have been reset (black and white)
```
