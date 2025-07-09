# Use official NGINX base image
FROM nginx:alpine

# Remove the default index page
RUN rm -rf /usr/share/nginx/html/*

# Copy custom index.html into NGINX web root
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Use the default command from nginx image

