# alpine is know as the most lightweight os, suitable for development
FROM python:3.10.4-alpine

# create a directory inside the docker container
RUN mkdir app
WORKDIR /app

# copy files and install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy application file
RUN mkdir app
COPY app/ app/
COPY entrypoint.sh .
COPY command.sh .

# add new user and make it as default user
# it is a bad practice to run your container with root user (security reasons)
RUN addgroup -S appgroup && adduser -D appuser -G appgroup
RUN chown -R appuser:appgroup /srv/
USER appuser

# expose port 5000 (we can use different port)
EXPOSE 5000

# specify the entrypoint of the container ( will be executed after the container is initialized)
ENTRYPOINT ["sh", "/app/entrypoint.sh" ]

# specify the commands that execute prior of running the app
CMD ["sh", "/app/command.sh" ]

RUN ls -ln