FROM gradle:jdk17

WORKDIR /app

RUN apt-get update && apt-get install -y curl && apt-get clean

EXPOSE 8080

ENTRYPOINT ["gradle", "bootRun", "--no-daemon"]
