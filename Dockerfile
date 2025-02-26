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
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    ln -s /root/.ollama/bin/ollama /usr/local/bin/ollama

# Ensure Ollama is in PATH for all subsequent commands
ENV PATH="/root/.ollama/bin:$PATH"

# Verify Ollama installation
RUN /usr/local/bin/ollama --version

# Download the LLM model (Change if using a different model)
RUN /usr/local/bin/ollama pull gemma:2b

# Expose the necessary port
EXPOSE 11434

# Start the application (modify based on your app)
ENTRYPOINT ["python", "main.py"]
