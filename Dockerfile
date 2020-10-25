# Name of the image we are going to base it from; Alpine is lightweight version of docker
FROM python:3.7-alpine

# Optional! who is maintainer of program
MAINTAINER Callicode

# Tells python to run in unbuffered mode, which is recommended when running python within docker containers
# Doesnt allow python to buffer the outputs and it prints in directly, avoids complications with docker in python app
ENV PYTHONUNBUFFERD 1

# Installing dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt


# Create an empty folder on docker image called /app to store our application source code
RUN mkdir /app

# Switches to that as thedefault directory, so any app we run using docker container will starting from this location, unless we
# specify otherwise
WORKDIR  /app

# Copy from local machine app folder to app folder we created on our image, this allowes us to take the code we created
# and copy it into our docker image
COPY ./app /app

# We are going to create a user that is going to run our app using docker
# This is for security purposes, if we dont do this the image will run app with root account
# Add user, (-D) add user for running applications only,
RUN adduser -D user
# We are going to switch to that user: USER-user switches docker to the user we just created
USER user


