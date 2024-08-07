# Use the official Hugo image as the base image
FROM klakegg/hugo:ext-alpine as builder

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Build the Hugo site
RUN hugo

# Use an Nginx container to serve the site
FROM nginx:alpine

# Copy the generated site from the Hugo container
COPY --from=builder /app/public /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
