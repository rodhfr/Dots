from pprint import pprint
from flask import Flask, request, jsonify
import threading
import time
import json
import os

app = Flask(__name__)

STATUS_FILE = "/tmp/runebar_status.json"


class Counter:
    value = 0
    activity_status = True
    last_active_time = 0


def activity_monitor():
    while True:
        if time.time() - Counter.last_active_time > 6:
            if Counter.activity_status:
                print("Player became inactive!")
            Counter.activity_status = False
            css_class = "red"
        else:
            Counter.activity_status = True
            css_class = "green"
        text = f"OSRS - Activity: {Counter.activity_status}"
        text = {"text": text, "class": css_class}
        # print(text, flush=True)
        print(json.dumps(text), flush=True)
        os.system("pkill -SIGRTMIN+10 waybar")
        time.sleep(1)


threading.Thread(target=activity_monitor, daemon=True).start()


@app.route("/")
def home():
    return "<h1>Welcome</h1>"


@app.route("/about")
def about():
    return "<h1>About us</h1>"


@app.route("/webhook", methods=["POST"])
def handle_webhook():
    # Step 1: Grab the 'payload_json' from the multipart form
    payload_json = request.form.get("payload_json")
    # print(payload_json)

    if not payload_json:
        return jsonify({"error": "No payload_json provided"}), 400

    # Step 2: Parse it as JSON
    try:
        data = json.loads(payload_json)
    except json.JSONDecodeError:
        return jsonify({"error": "Invalid JSON"}), 400

    # Step 3: Optionally handle the file (screenshot)
    # screenshot = request.files.get("file")
    # if screenshot:
    #     # For example, save it locally
    #     screenshot.save(f"./uploads/{screenshot.filename}")
    player_name = data["playerName"]
    print(player_name)

    if data["type"] == "EXTERNAL_PLUGIN":
        data_embed = data["embeds"][0]
        embed_description = data_embed["description"]
        pprint(embed_description)
        is_player_active = embed_description == "XP_DROP"
        if is_player_active:
            Counter.last_active_time = int(time.time())
        print("is_player_active:", Counter.activity_status)

        Counter.value += 1
        if Counter.value > 1000:
            Counter.value = 0
        print("Contador atual:", Counter.value)
    # Step 4: Process the JSON data
    # Example: just return it for demonstration
    return jsonify({"received": data}), 200


if __name__ == "__main__":
    # isso aqui e pra definir
    # como variavel de ambiente se por ex
    # definir antes do script PORT=8000
    # ai seria porta 8000 inves de 5000
    port = int(os.environ.get("PORT", 5000))
    # pra rodar o servidor flask
    app.run(debug=False, host="0.0.0.0", port=port)
