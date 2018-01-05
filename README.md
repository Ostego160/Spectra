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

Colors can be retrieved by calling them using the GET function.
```
love.graphics.setColor( spectra:get('blue') )
```
Colors are stored in the palette as named strings as indices.  

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

The MIX
