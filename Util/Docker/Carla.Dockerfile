FROM carla-prerequisites:latest

ARG GIT_BRANCH

USER ue4

RUN cd /home/ue4 && \
  if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com/illinois-ari/carla.git; \
  else git clone --depth 1 --branch $GIT_BRANCH https://github.com/illinois-ari/carla.git; fi

COPY --chown=ue4:ue4 Content/Carla /home/ue4/carla/Unreal/CarlaUE4/Content/Carla

COPY carla0.9.11_ue4.25.4.txt /home/ue4/carla
WORKDIR /home/ue4/carla
RUN patch -p1 < carla0.9.11_ue4.25.4.txt
#USER root
#RUN chown -R ue4:ue4 /home/ue4/carla/Unreal/CarlaUE4/Content
#USER ue4
WORKDIR /home/ue4/carla
RUN  mkdir Plugins && \
  make CarlaUE4Editor && \
  make PythonAPI && \
  make build.utils
USER root
RUN apt-get install -y vim
USER ue4
#RUN make package && \
#  rm -r /home/ue4/carla/Dist
