# Pie
 Pie (Passive Item Effects) is a small library for the Deltarune fangame engine, Kristal. Pie extends the default functionality of items to give them more functionality and make it easier to add custom item effects.
 
# Installation
 Using the Pie library in your mod is very easy! All you have to do is:
 - Go to the "Releases" section of this GitHub repository.
 - Download the source code for the latest release and extract it.
 - Place the `pie` folder into your mod's `libraries` folder.
 And with that, pie should be ready to use!
 
 If you're looking for a place to start with Pie, the source code also includes a handy set of examples in the `pie_examples` library. To see the examples in action, place the `pie_examples` into your `libraries` folder alongside `pie` and start experimenting!

# Usage and Functionality
 Pie comes with a handful of helpful additions to items from Kristal, including:
 - Lots of new callbacks, mostly inheriting from those found in the Encounter class, as well as a few custom ones.
 - Passive Item Effects for equipment such as auto-healing, damage over time and TP restoration. Perfect for mimicking functionality of the Stained Apron!
 - Healing boost effects for when items just aren't strong enough! Great at creating Burnt-pan style effects!
 - Healing from the past with new Future Heals for HealItems!
 - End of battle heals with Victory Healing!
 
 Plus, a plethora of getter functions allow you to have maximum customization over these values that should cover all your creative needs!
 
 Of course, you can't use these functions without knowing how they work! The best way to find out how is to explore the documentation provided directly in the code and take a look at the examples provided inside `pie_examples`. Or if you prefer a proper documentation, a GitHub wiki page will be available soon!
 
# Feedback
 If you have a suggestion for the library, or have ran into a bug, please make an issue for this repository so I can check it out! Or, even better, feel free to make a pull request implementing fixes or features yourself!
