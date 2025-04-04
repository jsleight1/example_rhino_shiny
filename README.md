# Example dockerised shiny application using [Rhino](https://appsilon.github.io/rhino/index.html) framework


The code for this shiny application is derived from the ['Create your first Rhino app'](https://appsilon.github.io/rhino/articles/tutorial/create-your-first-rhino-app.html) tutorial.


The application contains a `renv.lock` file which can be used to create a
reproducible environment using
[renv](https://rstudio.github.io/renv/articles/renv.html).

Alternatively, a docker image is available avaiable from
[docker.io](https://hub.docker.com/r/jsleight1/example_rhino_shiny).

## Example

The shiny application can be launched locally using:

``` r
rhino::app()
```

A dockerised version of the application can be launched using:

```
docker run -p 9001:9001 -it docker.io/jsleight1/example_rhino_shiny:latest
```
The application can then be viewed at:

```
http://localhost:9001/
```

***Please note the docker image is only avaiable for linux/arm64 and
linux/amd64 OS architectures.***

## Development

The repository contains two gitlab actions CI workflows that are used to aid development:
 - [dockerise.yaml](https://github.com/jsleight1/example_rhino_shiny/blob/main/.github/workflows/dockerise.yaml). On merging of a pull request to the main branch this file builds and pushes the `example_rhino_shiny` docker image to docker.io.
 - [rhino-test.yaml](https://github.com/jsleight1/example_rhino_shiny/blob/main/.github/workflows/rhino-test.yaml). This is based on a similar test workflow from the [Rhino showcase](https://github.com/Appsilon/rhino-showcase/tree/main) application built by Appsilon. This workflow lints and tests the application on pushes to main and opened pull requests.
