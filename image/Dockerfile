FROM openjdk:17-jdk-alpine3.13

RUN apk add --no-cache \
	graphviz \
	ttf-dejavu \
	fontconfig

ADD ./vendor/plantuml.jar /opt/plantuml/plantuml.jar

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/opt/plantuml/plantuml.jar", "-pipe"]
CMD ["-tsvg"]
