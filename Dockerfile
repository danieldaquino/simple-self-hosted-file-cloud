# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Install Samba and its dependencies
RUN apt-get update && \
    apt-get install -y samba && \
    rm -rf /var/lib/apt/lists/*

# Remove the default Samba configuration file
RUN rm /etc/samba/smb.conf

# Make a symbolic link from /config/smb.conf to /etc/samba/smb.conf
RUN ln -s /config/smb.conf /etc/samba/smb.conf

# Create a directory to share
RUN mkdir /samba-share && \
    chmod 777 /samba-share

# Expose the necessary ports
EXPOSE 139 445

# Keep the container running
CMD /usr/sbin/smbd -F
