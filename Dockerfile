# Use a lightweight Python base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Ensure Ollama is available in PATH
ENV PATH="/root/.ollama/bin:$PATH"

# Copy Nova files into the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Download the LLM model (Change if using a different model)
RUN ollama pull gemma:2b

# Expose necessary ports
EXPOSE 11434 4001 5001

# Start Nova and Ollama on container startup
CMD ["bash", "run.sh"]
