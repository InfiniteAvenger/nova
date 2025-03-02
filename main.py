from fastapi import FastAPI
import requests

app = FastAPI()

OLLAMA_HOST = "http://127.0.0.1:11434"  # Ensure this matches your Ollama setup

@app.get("/")
def read_root():
    return {"message": "Nova AI is running!"}

@app.post("/generate")
def generate_text(prompt: str):
    """
    Sends a prompt to Ollama and returns the AI-generated response.
    """
    response = requests.post(f"{OLLAMA_HOST}/api/generate", json={"model": "gemma:2b", "prompt": prompt})
    
    if response.status_code == 200:
        return response.json()
    else:
        return {"error": "Failed to generate response from Ollama"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
