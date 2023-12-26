# Use the Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Add a new Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the static webpage to the Nginx document root directory
COPY index.html /usr/share/nginx/html/