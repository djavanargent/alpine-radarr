FROM djavanargent/alpine-base-mono:latest
MAINTAINER djavanargent

# environment settings
ENV XDG_DATA_HOME="/config" \
    XDG_CONFIG_HOME="/config"

# Install radarr
RUN \
  mkdir -p /app/radarr && \
  radarr_tag=$(curl -sX GET "https://api.github.com/repos/Radarr/Radarr/releases" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o /build/radar.tar.gz -L "https://github.com/galli-leo/Radarr/releases/download/${radarr_tag}/Radarr.develop.${radarr_tag#v}.linux.tar.gz" && \
   tar ixzf /build/radar.tar.gz -C /app/radarr --strip-components=1 && \

# cleanup
  rm -rf /build/*

# add local files
COPY root /

# ports and volumes
VOLUME /config /downloads /movies
EXPOSE 7878
