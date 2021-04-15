FROM carla
USER root
RUN chown -R ue4:ue4 /home/ue4/carla/Unreal/CarlaUE4/Content
USER ue4