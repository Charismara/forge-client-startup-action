FROM openjdk:17-buster

COPY src/ /

ENTRYPOINT ["/entrypoint.sh"]