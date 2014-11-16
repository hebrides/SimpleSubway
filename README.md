SimpleSubway
============

Added a new menu opener button  by experimenting with home made [icon fonts](https://icomoon.io/) , and drawing background images for buttons with CG.

My first attempt at an iOS app. The goal for this project was to learn to make and publish a simple iOS app. I chose a subway map application because it seemed simple enough and I figured (rightly) there would be plenty of resources online to help me along the way. 

What's nice:

- Low memory use due to tiling images.
- I've written a utilities class that will set the frame of the map view to just below and just above the tab bar regardless of device -- I didn't like how iOS7 blurs the view beneath the tab bar.
- There is a small fix to Apple's old tiling code to get rid of a bug that would not always select the correct tile number.
- The UIWebView class is great for your "About" tab.
- Created a pop up menu by hand (it's a pain, but doable) for Bus Maps with an invisible dismiss area button. This was fun to figure out but I don't think it's intuitive for the user. 
- Uses a nifty Photoshop Script from [this repo](https://github.com/mattdipasquale/PicSciP/blob/master/Tile%20Images.jsx) with some modifications to make creating tiles a little easier for the Maps.

What needs improvement:

- I may look into accessing the NYC MTA database (free, I hear) to provide updates through push notifications.
- I don't know if my variables and code style are "right". I'm using many properties over instance variables, for example, and have hard coded all the layout because I find Interface Builder cumbersome. Looking forward to running this code by more experienced friends!

