# DaveMarkAIExperiment (WIP)
A Godot 4 experiment using the [Utility AI GDExtension](https://github.com/JarkkoPar/Utility_AI_GDExtension) to try and replicate a concept expressed by Dave Mark on [this Reddit comment](https://www.reddit.com/r/gameai/comments/lj8k3o/infinite_axis_utility_ai_a_few_questions/i0ajemb/)

## The Concept
As mentioned on the comment above, Dave Mark developed a Utility AI system that allowed him to have a character handle multiple actions in parallel.
He gives the example of a character wanting to build a fire because it is cold, looking around for wood, picking up food along the way (but ignoring it if it's too close too danger), and interacting with other friendly NPCs it finds on the way, after which it can return back to the campfire once it has enough wood and build the fire.

Intrigued by this concept, and seeking an idea to build upon and experiment with Utility AI, I decided to try and replicate these behaviors as best as I could.

While I could've tried to implement an Utility AI from scratch, that was beyond the scope of both my knowledge and the objective of my experiment (as it seeks not to learn how to create such a system, but interesting ways of using it on games), I decided to use the [Utility AI GDExtension created my JarkkoPar](https://github.com/JarkkoPar/Utility_AI_GDExtension). As a visual element, I used tiles and models created by [Kenney](https://www.kenney.nl/).

The final objective was to get, at a minimum, a simplified but close enough version of the behaviors described by Mr. Mark on his Reddit comment. Therefore, I would need to build a set of sensors, behaviours, considerations and actions such that I could have a character capable of:
* Be aware of temperature.
* Gather, keep track of and use resources, like wood.
* Have needs, like hunger, and the means to soothe them.
* Have the means to identify and notice danger.
* Have basic social interactions with other NPCs

## Changelog of features
### 11/01/24 The basics
As of the start of this repository, I have a basic system in place from which I can build upon. 
I have a character who can move around the map, losing energy as it moves, and replenish energy by eating; eating is directed by a pair of behaviours "FindFood" and "Eat", with 2-3 considerations each from which the character figures out if it's hungry, if it's at a food source or must seek one (currently one, position hardcoded) and move towards it, then eat once it's there until it is satisfied enough or it finds itself in danger (no danger sources are in yet, but the "is in danger" sensor can be toggled from the Godot inspector to forcefully interrupt the eating action), and afterwards will continue happily wandering around the map.
### 12/01/24 Smarter resource gathering
* FindFoodAction has been abstracted into FindResourceAction, and the character now knows to find the closest resource of the indicated type (thanks to Godot's groups).
* While the code involved is a bit of a mess, resources are now finite and the character can know the amount when searching and move to a different resource node if the current one runs out of food. This needs work however since if there are no resources left on the world the character will freeze on a loop of trying to find more, which is... less than ideal.



