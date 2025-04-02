ARG RVERSION=4.4.2
FROM rocker/r-ver:$RVERSION

# Install system dependencies
RUN apt-get update -qq \
  && apt-get install --yes \
    curl \
    libgdal-dev \
    libproj-dev \
    libudunits2-dev \
    sudo \
  && rm -rf /var/lib/apt/lists/*

# Install brave-browser required for shinytest2
RUN curl -fsS https://dl.brave.com/install.sh | sh

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