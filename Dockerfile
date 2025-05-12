# Use the official Microsoft SQL Server image
FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables for SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrongPassword123

# Create a directory to store scripts
RUN mkdir /usr/src/app

# Copy the database creation script to the container
COPY ./create-db.sql /usr/src/app/create-db.sql

# Copy the script to start the database
COPY ./init-db.sh /usr/src/app/init-db.sh

# Grant permissions to execute the script
RUN chmod +x /usr/src/app/init-db.sh

# Open port 1433 to connect to the database
EXPOSE 1433

# Command to start SQL Server and execute the script
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & /usr/src/app/init-db.sh"