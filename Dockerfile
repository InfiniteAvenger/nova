# Use Python 3.11 slim as the base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the local application files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Ollama properly
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    ln -s /root/.ollama/bin/ollama /usr/local/bin/ollama

# Verify Ollama installation
RUN ollama --version

# Download the LLM model (Change if using a different model)
RUN ollama pull gemma:2b

# Expose necessary ports
EXPOSE 11434

# Start the application (modify based on your app)
CMD ["python", "main.py"]
