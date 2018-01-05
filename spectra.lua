local Spectra = {
   _NAME          = 'Spectra Color Manager',
   _VERSION       = '1.0',
   _DESCRIPTION   = 'Color Management and Mixing Tool for LOVE2D',
   _LICENSE       = [[
   MIT License

   Copyright (c) 2017 William McCrea

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
   ]]
}
-------------------------------
-- |||HELPERS|||
-------------------------------
local push = table.insert
local function clamp(low, n, high) return math.min(math.max(low, n), high) end
local function dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
function lerp(a,b,t) return (1-t)*a + t*b end
function cerp(a,b,t) local f=(1-math.cos(t*math.pi))*.5 return a*(1-f)+b*f end
local function querp(a,b,c,t)
   return   (1-t)^2 * a +
            (1-t)*2 * t * b +
            t^2 * c
end
local function cuberp(a,b,c,d,t)
   return   (1-t)^3 * a +
            (1-t)^2 * 3*t * b +
            (1-t) * 3 * t^2 * c +
            t^3 * d
end
-------------------------------
-- |||PALETTE|||
-------------------------------
local function loadPalette()
   local palette = {}
   palette['black'] =      {0,0,0}
   palette['gray'] =       {128,128,128}
   palette['darkgray'] =   {64,64,64}
   palette['lightgray'] =  {192,192,192}
   palette['white'] =      {255,255,255}
   palette['red'] =        {255,0,0}
   palette['orange'] =     {255,165,0}
   palette['yellow'] =     {255,255,0}
   palette['green'] =      {0,255,0}
   palette['blue'] =       {0,0,255}
   palette['magenta'] =    {255,0,255}
   palette['brown'] =      {165,42,42}
   --Red
   palette['lightsalmon']= {255,160,122}
   palette['salmon'] =     {250,128,114}
   palette['darksalmon'] = {233,150,122}
   palette['lightcoral'] = {240,128,128}
   palette['coral'] =      {255,127,80}
   palette['indianred'] =  {205,92,92}
   palette['tomato'] =     {255,99,71}
   palette['blood'] =      {187,10,30}
   palette['sanguine'] =   {133,5,5}
   palette['orangered'] =  {255,69,0}
   palette['crimson'] =    {220,20,60}
   palette['firebrick'] =  {178,34,34}
   palette['darkred'] =    {139,0,0}
   palette['maroon'] =     {128,0,0}
   --Orange
   palette['lightpeach'] = {251,212,185}
   palette['peach'] =      {251,194,153}
   palette['darkpeach'] =  {254,168,119}
   palette['lightorange'] ={255,195,77}
   palette['darkorange'] = {255,140,0}
   palette['burntorange'] ={229,83,0}
   --Yellow
   palette['lightyellow'] ={255,255,224}
   palette['goldyellow'] = {255,223,0}
   palette['goldenrod'] =  {218,165,32}
   --Green
   palette['limegreen'] =  {50,205,50}
   palette['greenyellow'] ={173,255,47}
   palette['lightgreen'] = {144,238,144}
   palette['seagreen'] =   {46,139,87}
   palette['olive'] =      {128,128,0}
   palette['olivedrab'] =  {107,142,35}
   palette['forestgreen'] ={34,139,34}
   palette['darkgreen'] =  {0,100,0}
   --Blue
   palette['cyan'] =       {0,255,255}
   palette['aqua'] =       {127,255,212}
   palette['skyblue'] =    {135,206,235}
   palette['lightblue'] =  {173,216,230}
   palette['turqoise'] =   {64,224,208}
   palette['teal'] =       {0,128,128}
   palette['dodgerblue'] = {30,144,255}
   palette['steelblue'] =  {70,130,180}
   palette['royalblue'] =  {65,105,225}
   palette['blueviolet'] = {138,43,226}
   palette['slateblue'] =  {106,90,205}
   palette['navyblue'] =   {0,0,128}
   palette['midnight'] =   {16,16,64}
   --Purple
   palette['lavender'] =   {230,230,250}
   palette['plum'] =       {221,160,221}
   palette['violet'] =     {238,130,238}
   palette['purple'] =     {147,112,219}
   palette['darkpurple'] = {128,0,128}
   palette['indigo'] =     {75,0,130}
   --Brown
   palette['eggshell'] =   {240,234,214}
   palette['wheat'] =      {245,222,179}
   palette['tan'] =        {210,180,140}
   palette['sienna'] =     {160,82,45}
   palette['saddlebrown'] ={139,69,19}
   palette['darkbrown'] =  {40,26,13}
   return palette
end
-------------------------------
-- |||SPECTRA CLASS|||
-------------------------------
Spectra.__index = Spectra
setmetatable(Spectra, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Spectra.new(palette)
   local self = setmetatable({}, Spectra)
   self.palette = palette or loadPalette()

   self.rMin, self.gMin, self.bMin = 0,0,0
   self.rMax, self.gMax, self.bMax = 255,255,255
   return self
end
-------------------------------
-- |||MODULE|||
-------------------------------
-- COLOR COUNT - Returns total number of colors
function Spectra:colorCount()
   local count = 0
   for k,v in pairs(self.palette) do count = count+1 end
   return count
end
-------------------------------
-- GET - Return RGB value by name
function Spectra:get(color, alpha)
   assert(self.palette[color], 'Spectra Error: Color Not Found')
   return self.palette[color][1],self.palette[color][2],self.palette[color][3],alpha
end
-------------------------------
-- EDIT - Add or change color in palette
function Spectra:edit(color, r,g,b)
   self.palette[color] = {r,g,b}
end
-------------------------------
-- MIX - Apply shade/fade to color and filter by color (by factor 0-1)
function Spectra:mix(color,alpha,shade, color2,factor)
   if shade then s=math.max(0,shade/255) else s=1 end
   local r1,g1,b1 = self:get(color)
   if not color2 then
      return   clamp(self.rMin,r1*s,self.rMax),
               clamp(self.gMin,g1*s,self.gMax),
               clamp(self.bMin,b1*s,self.bMax),
               clamp(0,alpha,255)
   else
      local r2,g2,b2 = self:get(color2)
      local t = clamp(0,factor,1)
      return   clamp(self.rMin, lerp(r1,r2,t)*s, self.rMax),
               clamp(self.gMin, lerp(g1,g2,t)*s, self.gMax),
               clamp(self.bMin, lerp(b1,b2,t)*s, self.bMax),
               clamp(0,alpha,255)
   end
end
-------------------------------
-- GRADIENT - Mix 2-4 colors based on distance / range
function Spectra:gradient(range, distance, colorTable)
   local size = 0
   local c,a,t,s = {}, colorTable['alpha'] or 255, clamp(0,distance/range,1),1
   if colorTable['shade'] then s=clamp(0,(255-colorTable['shade'])/255,1) end
   for _,color in pairs(colorTable) do
      if type(color) == 'string' then
         push(c, {self:get(color)})
         size = size+1
      end
   end
   if size == 2 then return
      clamp(self.rMin, lerp(c[1][1]*s,c[2][1]*s,t), self.rMax),
      clamp(self.gMin, lerp(c[1][2]*s,c[2][2]*s,t), self.gMax),
      clamp(self.bMin, lerp(c[1][3]*s,c[2][3]*s,t), self.bMax),
      clamp(0,a,255)
   elseif size == 3 then return
      clamp(self.rMin, querp(c[1][1]*s,c[2][1]*s,c[3][1]*s,t), self.rMax),
      clamp(self.gMin, querp(c[1][2]*s,c[2][2]*s,c[3][2]*s,t), self.gMax),
      clamp(self.bMin, querp(c[1][3]*s,c[2][3]*s,c[3][3]*s,t), self.bMax),
      clamp(0,a,255)
   elseif size == 4 then return
      clamp(self.rMin, cuberp(c[1][1]*s,c[2][1]*s,c[3][1]*s,c[4][1]*s,t), self.rMax),
      clamp(self.gMin, cuberp(c[1][2]*s,c[2][2]*s,c[3][2]*s,c[4][2]*s,t), self.gMax),
      clamp(self.bMin, cuberp(c[1][3]*s,c[2][3]*s,c[3][3]*s,c[4][3]*s,t), self.bMax),
      clamp(0,a,255)
   end
end
-------------------------------
-- CLAMP - Set min and max RGB values based on color (by factor 0-1)
function Spectra:clamp(minColor,minFactor, maxColor,maxFactor)
   if not minColor then
      self.rMin, self.gMin, self.bMin = 0,0,0
      self.rMax, self.gMax, self.bMax = 255,255,255
   else
      local r1,g1,b1 = self:get(minColor)
      local r2,g2,b2 = self:get(maxColor)
      local t1 = clamp(0,minFactor,1)
      local t2 = clamp(0,maxFactor,1)

      self.rMin = math.floor(lerp(0,r1,t1))
      self.gMin = math.floor(lerp(0,g1,t1))
      self.bMin = math.floor(lerp(0,b1,t1))

      self.rMax = math.floor(lerp(255,r2,t2))
      self.gMax = math.floor(lerp(255,g2,t2))
      self.bMax = math.floor(lerp(255,b2,t2))
   end
end
-------------------------------
return Spectra
