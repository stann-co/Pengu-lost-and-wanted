import json

info = {
    "name": "Pre-Run Step",
    "version": "1.0.0",
    "description": "A script that runs before the main application starts.",
}

with open("datafiles/editor_info.json", "w") as f:
    json.dump(info, f, indent=4)
