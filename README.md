# Godot Scene Transition Plugin
 
A simple and powerful transtion plugin

## 🌟 Highlights
- 👍 easy to use
- 🪶 lightweight
- 🛠️ many transitions:

## 🚀 Usage
like this:
```
SceneTransition.diamond_in()
```

or in a full context:

 ```
func start_battle():
	get_tree().paused = true

	await SceneTransition.circle_in()
	get_tree().change_scene_to_packed(BATTLE_SCENE)
	await SceneTransition.circle_out()
	
	get_tree().paused = false
```

## ⬇️ Installation
If you don't have a "addons" folder in your project tree:

	copy the "addons" folder in your project tree
	
elif you have a "addons" folder already:

	copy the "scene_transition" folder in your "addons" folder

At the end it should look like this:


## 📜 Credits
- Scribbles images by jabsatz https://github.com/glass-brick/Scene-Manager
- Horizontal Paint Brush Wipe image by Kdenlive Lumas, via KDE Store https://store.kde.org/p/1675120
