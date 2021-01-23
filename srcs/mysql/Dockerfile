
FROM alpine:3.12

WORKDIR	/project

# RUN		apk update && apk add 	mysql \
								# mandoc man-pages vim

COPY	./script.sh /project/script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "/project/script.sh"]