# Use Alpine-based Python image
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Install Flask
# We combine RUN commands to reduce layers and use --no-cache to keep the image small
RUN apk add --no-cache gcc musl-dev linux-headers && \
    pip install --no-cache-dir flask && \
    apk del gcc musl-dev linux-headers

# Create a simple Flask app
COPY <<EOF /app/app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World! This is the lightweight Intel PoC Docker image."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5010)
EOF

# Make port 5010 available to the world outside this container
EXPOSE 5010

# Run the app when the container launches
CMD ["python", "app.py"]
