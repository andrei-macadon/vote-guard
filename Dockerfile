FROM ubuntu:20.04
LABEL authors="andreimacadon"

# Install dependencies (Java, Maven, PostgreSQL client if needed)
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    openjdk-17-jdk \
    maven \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-arm64
ENV PATH $JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy entire source code
COPY src ./src
COPY pom.xml .

# Build the application (skip tests)
RUN mvn clean package -Ppackage

# Run the application (example command)
CMD ["java", "-jar", "target/vote-guard.jar"]

# Example: Run tests (if needed, replace with your actual test command)
# RUN mvn test