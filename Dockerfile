# Use the official PostgreSQL image as the base image
FROM postgres:15.2

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential git cmake

# Clone and build pgvector
RUN git clone https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    git checkout tags/1.0.0 && \
    cmake . && \
    make && \
    make install

# Enable the pgvector extension
RUN echo "shared_preload_libraries = 'pg_vector'" >> /usr/share/postgresql/postgresql.conf.sample

# Expose the default PostgreSQL port
EXPOSE 5432

