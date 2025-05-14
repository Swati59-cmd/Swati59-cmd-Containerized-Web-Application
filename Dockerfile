# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create templates directory and move the template file
RUN mkdir -p templates
COPY templates/index.html templates/

# Set environment variables
ENV PORT=5000

# Expose port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
