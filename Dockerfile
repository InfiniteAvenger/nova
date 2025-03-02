# Use Python 3.11 slim as the base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the local application files into the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Set Ollama environment variables
ENV OLLAMA_HOME="/root/.ollama"
ENV OLLAMA_HOST="0.0.0.0:11434"

# Ensure main.py exists
RUN test -f /app/main.py || (echo 'Error: main.py not found!' && exit 1)

# Expose the necessary ports
EXPOSE 11434 8000

# Start Ollama in the background, wait for it to initialize, then pull the model and run the app
CMD ["sh", "-c", "ollama serve --host 0.0.0.0 & sleep 5 && ollama pull gemma:2b && exec python /app/main.py"]
