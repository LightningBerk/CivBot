This bot is pretty simple to use. There are a few rewuirements your farm has to fit for it to work.
Firstly you will need to have any and all water holes covered by trapdoors
Secondly you will need to have a 1-block perimiter along the edge of your farm with a 1 block trench behind it. This allows the bot to shift-walk backwards toreset its position
And lastly the most complicated part. The bot harvests going forward to positive x, then left, then forward to negative x, then right. You will need to edit the coordanates in 
the code. Don't worrt this is fairly straightforward. If you look in the code you will see the number -662 show up a fre times, replace all of the -662s with the greatest x value 
of your farm (including the 1 block perimiter). Then replace all the -746s with the smallest x value on your farm (including the 1 block perimiter). Save the script. Now for the 
last bit of setup, position your player on the back left perimiter block with the first row of crops in front of you, hold shift and walk all the way back to the edge of the block
and run the script! The only thing i need to add is a chest depositing system. So depending on the size of your farm you will need to empty your inventory periodically. If your
iventory fills up just hit ctrl + shift + whatever keybind you set for advanced macros to stop the script, empty your inventorty and then repeat the setup on the last row you 
harvested making sure you are facing twards positive x. Thats all! Any feedback is appreciated!
