# Use official Java image as base
FROM openjdk:21-slim

# Set working directory
WORKDIR /minecraft

# Set Minecraft Forge version and Java memory allocation via environment variables
ENV MC_VERSION=1.21.8
ENV FORGE_VERSION=58.1.0
ENV XMX=2G 
ENV XMS=1G

# Install required tools
RUN apt-get update && apt-get install -y curl

# Download Forge installer
RUN curl -o forge-installer.jar \
    https://maven.minecraftforge.net/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar

# Run Forge installer to set up the server
RUN java -jar forge-installer.jar --installServer

# Accept Minecraft EULA
RUN echo "eula=true" > eula.txt

# Clean up Forge installer and rename generated server JAR to a consistent filename
RUN rm forge-installer.jar \
    && find . -maxdepth 1 -type f -name "forge-*-*-*.jar" -exec mv {} forge-server.jar \;

# Expose default Minecraft port
EXPOSE 25565

# Start the Forge server
CMD java -Xmx${XMX} -Xms${XMS} -jar forge-server.jar nogui

