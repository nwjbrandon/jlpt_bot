
# docker run --rm --env-file .env jlpt-bot
FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install uv to resolve dependencies from uv.lock reproducibly.
RUN pip install --no-cache-dir uv==0.8.17

COPY pyproject.toml uv.lock main.py ./
RUN uv sync --frozen --no-dev --no-install-project

COPY data/ ./data

CMD ["./.venv/bin/python", "main.py"]