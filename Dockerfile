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
RUN curl -fsSL https://ollama.com/install.sh | sh

# Ensure Ollama is in PATH
ENV PATH="/root/.ollama/bin:$PATH"

# Pull the Ollama model before runtime
RUN /root/.ollama/bin/ollama pull gemma:2b

# Expose the necessary port
EXPOSE 11434

# Start Ollama as a background process & run the app
CMD /root/.ollama/bin/ollama serve & sleep 2 && python main.py
