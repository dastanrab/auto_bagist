FROM nginx:1.29.1

# Install build dependencies
RUN apt-get update && \
    apt-get install -y wget build-essential libpcre3-dev zlib1g-dev libssl-dev libmaxminddb-dev && \
    apt-get clean

# Download Nginx source and GeoIP2 module
RUN cd /tmp && \
    wget http://nginx.org/download/nginx-1.29.1.tar.gz && \
    wget https://github.com/leev/ngx_http_geoip2_module/archive/refs/tags/3.4.tar.gz -O ngx_http_geoip2_module.tar.gz

# Extract and build the module
RUN cd /tmp && \
    tar -xzf nginx-1.29.1.tar.gz && \
    tar -xzf ngx_http_geoip2_module.tar.gz && \
    cd nginx-1.29.1 && \
    ./configure --with-compat --add-dynamic-module=../ngx_http_geoip2_module-3.4 && \
    make modules

# Copy built module to nginx module dir
RUN cp /tmp/nginx-1.29.1/objs/ngx_http_geoip2_module.so /etc/nginx/modules/ && \
    rm -rf /tmp/*

# Create GeoIP directory
RUN mkdir -p /usr/share/GeoIP

# Remove default config to prevent entrypoint conflicts
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy our custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/conf.d/
