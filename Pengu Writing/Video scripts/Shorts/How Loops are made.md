Loops

Have you ever seen a loop in a game?

Just like Sonic, My game has plenty of them. But how do they actually work? 

  

If its a 3d game its of course just a question of the character moving back and forth so it can go over or under.

  

But this is a 2d pixelart game, so how do we do it?

  

In my game, this is actually handled with extra collision layers,  
And toggled with trigger zones! 

  

You can see I have 3 unique layers that get switched when you enter any one of these trigger zones.

  

And then I also made these special dual trigger zones, that change depending on which side of it that you're on.

  

With this I can make a layer switch just as you go through a loop, and switch it back on the way out as well!

  

That last part is pretty important,  because if I don't do it carefully, it’s possible for the player to jump out from the loop while still being on the second collision layer.

  

And end up falling through the world

  
*backrooms joke*

This is probably also why this iconic loop from green hills zone in sonic  
has this little notch at the end. To make sure you can't jump over the trigger on the way out!

In an earlier version, when you went through one of these, and I suspect it might be this way in older games too. It actually just changed which layers were active, for every single object in the level. This mostly worked, but it could result in some objects behaving oddly, and also meant that enemies would not be able to follow you through any of these places.

  

So now every single object in my game has their own collision layer variable that changes whenever they enter one of these zones.

  

I have plenty of other fancy tools, zones and triggers in my game, so let me know if you’re curious about anything else, for another video.

And now you know all about….

The, uhh video was supposed to loops