FROM openjdk:17-buster

COPY src/entrypoint.sh /entrypoint.sh
CMD chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]