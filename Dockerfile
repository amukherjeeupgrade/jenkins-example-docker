FROM ubuntu
#If docker build gets the wrong time , might need apt-get -o Acquire::Max-FutureTime=86400 update //openjdk-17-jre
RUN apt-get update && apt-get install -y openjdk-17-jdk wget unzip libwebkit2gtk-4.0 firefox
# Download snapshot build, just for testing
RUN wget "http://www.eclipse.org/downloads/download.php?file=/mat/snapshots/rcp/org.eclipse.mat.ui.rcp.MemoryAnalyzer-linux.gtk.x86_64.zip&mirror_id=1" -O /tmp/org.eclipse.mat.ui.rcp.MemoryAnalyzer-linux.gtk.x86_64.zip
RUN unzip /tmp/org.eclipse.mat.ui.rcp.MemoryAnalyzer-linux.gtk.x86_64.zip -d /opt
# ENV DISPLAY host.docker.internal:0.0
ENV JAVA_OPTS="-Xmx1024m"
VOLUME ["/dump"]

ADD parse-dump.sh /opt
# CMD ["/opt/mat/MemoryAnalyzer"]
ENTRYPOINT ["/opt/parse-dump.sh"]
