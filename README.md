# Spectra
Spectra Color Manager for LOVE2D


## Description:

The Spectra Color Manager for LOVE2D stores a palette, RGB clamp values, and color mixing functions.  It was created to store color values and to create a gradient effects, especially tile color values.

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

Colors can be retrieved by calling them using the GET function.  The first argument is the name of color as a string.  The second, optional argument is the alpha value to be passed through.
```
--Blue without alpha channel
love.graphics.setColor( spectra:get('blue') )

--Blue with alpha channel
love.graphics.setColor( spectra:get('blue', 128) )
```

### Edit

Colors can be modified or created using the EDIT function.  The named color is passed as the first argument as a string.  The following three arguments are the respective RGB values for the edit.
```
--Create New Color
spectra:edit('myColor', 255,255,255)

--Edit Existing Color
spectra:edit('gray', 100,100,100)
```
Colors are stored in the palette as named strings as indices.  

### ColorCount

The COLORCOUNT function can be used to return the total amount of stored colors in the palette.
```
numberOfColors = spectra:colorCount()
```

### Mix

The MIX function combines two colors by a factor 0-1 as well as applying alpha and lighten/darken effects.
```
Spectra:mix(color,alpha,shade, color2,factor)
```
The first three arguments indicate initial color, alpha, and a shade value.  The shade value default is 255; increasing or decreasing this value brightens or darkens the color respectively.

The second color is optional, however it will combine with the first by a factor of 0-1 (A value of .5 means exactly halfway between the colors.)  
