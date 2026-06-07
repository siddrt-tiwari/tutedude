from flask import Flask, render_template, request
import requests

app = Flask(__name__)

BACKEND_URL = "http://13.232.25.157/:3000/api/submit"

@app.route("/", methods=["GET", "POST"])
def home():

    success_message = None

    if request.method == "POST":

        payload = {
            "name": request.form["name"],
            "email": request.form["email"],
            "message": request.form["message"]
        }

        try:
            response = requests.post(BACKEND_URL, json=payload)

            if response.status_code == 200:
                success_message = response.json()["message"]
            else:
                success_message = "Submission failed."

        except Exception as e:
            success_message = f"Error: {e}"

    return render_template(
        "index.html",
        success_message=success_message
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)