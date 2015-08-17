//via https://www.youtube.com/watch?v=Uwn_QFjbl1k

Hi,

The primary script of this package is called NodeControl, it has one function called DeepPath. this function takes two positions, a start and and end, it will give you back a list of positions that form the path.
The Actor class is an example of a script that will ask for a path and follow it, you do not need to use the method if you don't want to. the Camera control is just so you can interface with the actor.

Please feel free to make the ExampleScene as complicated as you would like to test out the script and understand hoe the NodeControl script works.

Common problems:
-Make sure to surround any box collider with nodes.
-Make sure the nodes don't have box colliders.
-If you don't want to path through an area surround it with a box collider, it doesn't need a renderer.
-Make sure you have filled in all the public variables of the scripts
-Make sure the nodes and the floor have a tag and it corresponds to the public variable on the CameraControl and NodeControl scripts.