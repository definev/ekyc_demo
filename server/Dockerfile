# Write a docker file to build a docker image run main.py
# Use the python:3.10.4 image
# Install the python packages in requirements.txt
# Run main.py
# Expose port 8000 to the host

# Use the python:3.10.4 image
FROM python:3.10.4

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# Install the python packages in requirements.txt
COPY ./requirement.txt requirement.txt
RUN pip install --upgrade pip
RUN pip install -r requirement.txt

COPY . .

EXPOSE 8000

# Run main.py
CMD ["python", "main.py"]

# Expose port 8000 to the host

# # Build the docker image
# docker build -t hello-world .

# # Run the docker image
# docker run -p 8000:8000 hello-world

# # Run the docker image in the background
# docker run -d -p 8000:8000 hello-world

# # List all docker images
# docker images

# # List all docker containers
# docker ps --all
