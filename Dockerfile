# Use an official Python image as base
FROM python:3.10

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git clang cmake ninja-build pkg-config libgtk-3-dev \
    liblzma-dev lcov

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor

# Install Python dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app
COPY . .

# Run Flask app
CMD ["python", "app.py"]
