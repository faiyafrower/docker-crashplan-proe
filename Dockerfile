FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    wget \
    cpio \
    libgtk2.0-0 \
    libnotify4 \
    libgconf2-4 \
    libnss3 \
    libasound2 \
    libcanberra-gtk-module
# For testing purposes
#    vim \
#    firefox

# Download and extract CrashPlan
RUN wget https://desktopbackup.it.umich.edu:4285/client/installers/Code42CrashPlan_5.4.3_1465571600543_9_Linux.tgz
RUN tar -xvf Code42CrashPlan_5.4.3_1465571600543_9_Linux.tgz
RUN rm /Code42CrashPlan_5.4.3_1465571600543_9_Linux.tgz

# Copy the silent install script for CrashPlan into the container
COPY crashplan_silentinstall.sh /crashplan-install/
RUN mv /crashplan-install/crashplan_silentinstall.sh /crashplan-install/silentinstall.sh
WORKDIR /crashplan-install
RUN chmod 755 silentinstall.sh

# Run the silent installer and make sure the CrashPlan service is running
RUN ./silentinstall.sh
RUN service crashplan start
