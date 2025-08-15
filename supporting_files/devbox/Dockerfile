FROM debian:trixie-20250721

COPY . /tmp

USER root

RUN /tmp/configure-container-image.sh

USER wtaylor
WORKDIR /home/wtaylor
RUN mkdir -p ./.config/fish/conf.d \
  && echo "/home/linuxbrew/.linuxbrew/bin/brew shellenv | source" >./.config/fish/conf.d/brew.fish

CMD ["sleep", "infinity"]
