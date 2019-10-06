# Fog of War
A plugin for Unity3D to add Fog of War to a game.

<b>
UPDATE 1.3 : <br>
Added an option to keep the cleared area unfoged. <br>
(Please test this and create an issue if you find any errors)
</b>
<br> <br>
<b>
UPDATE 1.2 : <br>
Added a feature for multiple targets to uncover fog.
</b>
<br> <br>
<b>
UPDATE 1.1 : <br>
Supports SRP, please check the scene in the unitypackage to see how to setup in HDRP. (Same case with your own SRP)
</b>

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/XFs8cucJ764/0.jpg)](https://www.youtube.com/watch?v=XFs8cucJ764)

<br>
<b>Steps to use plugin</b><br>
<ol>
  <li>Copy all contents of this repository in your Assets</li>
  <li>Add "Prefabs/Fog" to your scene</li>
  <li>Drag gameobject from scene that has to defog the area to "Center" slot in the added Fog object</li>
  <li>Add "Scripts/PreRenderCalls" to your rendering camera</li>
  <li>Drag "Fog" gameobject from scene to Fog slot in PreRenderCalls</li>
  <li>Play with settings to best suit your system budgets over quality</li>  
</ol>

<b>Enjoy...</b>
