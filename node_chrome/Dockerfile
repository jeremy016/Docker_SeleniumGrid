FROM selenium/node-chrome-debug

ENV NODE_MAX_INSTANCES 10

ENV NODE_MAX_SESSION 10

RUN mkdir /home/seluser/Downloads

RUN x11vnc -storepasswd 88888888 /home/seluser/.vnc/passwd
