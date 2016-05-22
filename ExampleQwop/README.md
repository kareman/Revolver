# Revolver Example: QWOP
This example shows how Revolver can discover a strategy to play an online game with human-competitive results.

## The QWOP Game
> QWOP (/kwɒp/) is a 2008 ragdoll-based Flash game created by former Cut Copy bassist Bennett Foddy. Players control an athlete named "Qwop" using only the Q, W, O, and P keys. A couple of years after the game was released on the internet, the game became an internet meme after its outbreak in December 2010. The game helped Foddy's site (Foddy.net) reach 30 million hits.

[Read more](https://en.wikipedia.org/wiki/QWOP) about the game on Wikipedia or [go play QWOP](http://www.foddy.net/Athletics.html) online right now.

## Credits
The example code was created by [Petr Mánek](https://github.com/petrmanek), Charles University, 2016. The [Qwopper software](https://github.com/slowfrog/qwopper) and strategy encoding were developed by Laurent Vaucher in 2011 (more information can be found in [this blog post](https://slowfrog.blogspot.cz/2011/03/genetically-engineered-qwop-part-1.html)).

This example is distributed under the [MIT License](https://en.wikipedia.org/wiki/MIT_License).

## Dependencies

 - Revolver
 - Xcode 7.3
 - Mac OS 10.11 El Capitan *(perhaps this example can be ported to Linux?)*

## Usage

 1. Build and run the project in Xcode. *(don't use xcodeproj in this directory, use xcworkspace in the parent directory)*
 2. Hit the *Run algorithm* button.
 3. Observe how the randomly generated artificial player play the game.
 4. Change parameters of the algorithm in `ViewController.swift` and observe how the output changes.

## Example Ouptut

This is the output of the algorithm after 18 hours of continuous running.

 - Best Chromosome: `oQqpqQWWPqQqWoOwqOqoPpQOwPWo+oowOqWqwWqwOp+qoPOwpoWWOQwowqW+WOP+qqwpo+QqwpqPwp`
 - Best Chromosome Fitness: 0.224 (100 meters in 152 seconds)
 
Here's a short recording of the run: *(click the image to watch the full video)*

<a href="http://www.youtube.com/watch?feature=player_embedded&v=Rf9DKOTF1oA
" target="_blank"><img src="best_strategy.gif" 
alt="Watch the full run of the best strategy." border="10" /></a>

## Common Problems

 1. **Qwopper cannot "find origin."**
 
    When Qwopper is launched, it makes a screenshot and looks for the open game. This error means that it failed.
 
    Possible causes are:
      - **QWOP game is not open or visible.**
        
        Make sure the [QWOP game](http://www.foddy.net/Athletics.html) is open and fully visible in your window manager. If you have multiple screens, make sure **QWOP is on screen no. 1**. If the problem persists, try moving the window with the game by a pixel or two (this helps sometimes as Qwopper searches the screenshots in 4px batches).
        
      - **You are using different color scheme.**
      
        Qwopper is looking for a particular color edge in the screenshot. It is possible that your colors are slightly different from those of the computer, on which this software was developed. Try changing your system's color scheme and running Qwopper again. Also make sure that software like *flux* or *redshift* is not running.
        
      - **The colors just don't match.**
      
        If you have no luck changing your color scheme, you are going to have to manually change the colors Qwopper looks for. The constants are located in [Qwopper.java](qwopper/src/com/slowfrog/qwop/Qwopper.java) (see fields `refColor`, `refColor2` and `refColor3`).
        
        After you get Qwopper working, don't forget to copy the .jar to the [Swift project folder](ExampleQwop/)!
        
 2. **Qwopper reports "OCR error" or "java.lang.NumberFormatException."**
 
    Qwopper includes a simple threshold-based OCR algorithms to read the distance ran. This error means that there was some problem in reading the distance.
    
    Possible causes are:
      - **The game window was repositioned during the run.**
      
        Once Qwopper is launched, it remembers the exact position of the game window for the duration of its execution. This position is used to determine the location of the distance label for the OCR. If you move the window later on, Qwopper's OCR fails. For that reason, make sure you **do not manipulate the QWOP window after Qwopper is launched.**
        
      - **Your fonts are rendered differently.**
      
        To recognize individual digits, Qwopper's OCR uses a template image for thresholding and comparison. Since the tolerance setting is quite low, imperfect matches may cause Qwopper to rather fail than risk imprecise OCR. This is often the case when Qwopper is ported to different platforms (or computers).
        
        To resolve this issue, you can try opening QWOP in different web browsers or playing with your system's font rendering configuration. If you have no luck, you are going to have to replace the template image Qwopper uses to match individual digits with the thresholded pixels. By experience, the best way to obtain data for such image is to play QWOP manually in order to induce the game to display all digits (say run 0.1 meters, then 0.2 meters, etc.). For every digit, create a screenshot and use the thresholding filter of your favorite image editor to generate image such as [this one](qwopper/img/digits.png). Then, replace the image with your custom one, compile Qwopper and attempt to run it again.
        
        After you get Qwopper working, don't forget to copy the .jar to the [Swift project folder](ExampleQwop/)!

