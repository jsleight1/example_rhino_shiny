ARG RVERSION=4.4.2
FROM rocker/r-ver:$RVERSION

# Install system dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    curl \
    libgdal-dev \
    libproj-dev \
    libudunits2-dev \
    sudo

# Install brave-browser required for shinytest2
RUN curl -fsS https://dl.brave.com/install.sh | sh

# Install node js
ENV NODE_VERSION=16.13.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Run application as 'app' user.
RUN addgroup --system app && adduser --system --ingroup app app
RUN mkdir /home/app
RUN chown app:app /home/app
ENV HOME=/home/app
WORKDIR /home/app

# Copy app
COPY --chown=app:app app.R ./
COPY --chown=app:app config.yml ./
COPY --chown=app:app rhino.yml ./
COPY --chown=app:app app app/

# Install R dependencies
COPY --chown=app:app .Rprofile renv.lock ./
COPY --chown=app:app renv/activate.R renv/
RUN Rscript -e 'renv::restore(clean = TRUE)'

# Expose port and run shiny application
USER app
EXPOSE 9001