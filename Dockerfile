FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml README.md ./
COPY src/ ./src/

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir .

RUN playwright install chromium --with-deps

COPY . .

EXPOSE 8501 8010

CMD ["streamlit", "run", "src/cognitive_kitchen/ui/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
