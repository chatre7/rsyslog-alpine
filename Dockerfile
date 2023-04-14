# Use a base image
FROM alpine

# Install rsyslog package
RUN apk add --no-cache rsyslog

# Copy rsyslog configuration file to container
COPY rsyslog.conf /etc/rsyslog.conf

# Create log folder
RUN mkdir -p /var/log/remote

# Create syslog user and group
RUN addgroup -S syslog && adduser -S -G syslog syslog

# Set ownership and permissions for log folder
RUN chown -R syslog:syslog /var/log/remote && chmod 755 /var/log/remote

# Expose syslog port (514/udp)
EXPOSE 514/udp

# Start rsyslog service
CMD ["rsyslogd", "-n"]
