# Use Python 3.11 slim as the base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the local application files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    mkdir -p /usr/local/bin && \
    ln -s /root/.ollama/bin/ollama /usr/local/bin/ollama

# Ensure Ollama is in PATH for all subsequent commands
ENV PATH="/root/.ollama/bin:$PATH"

# Verify Ollama installation
RUN echo "Checking Ollama binary location..." && which ollama && ollama --version

# Download the LLM model (Change if using a different model)
RUN ollama pull gemma:2b

# Expose necessary ports
EXPOSE 11434

# Start the application (modify based on your app)
CMD ["python", "main.py"]
