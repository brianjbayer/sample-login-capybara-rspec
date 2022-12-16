# #-----------------------------------
# #--- sample-login-capybara-rspec ---
# #-----------------------------------

# # Local Build Instructions
# # To Build the deploy image...
# #   docker build --no-cache -t brianjbayer/sample-login-capybara-rspec:local .
# # To build the development environment image...
# #   docker build --no-cache --target devenv -t browsertests-dev .

# # NOTE: From https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
# #       "FROM instructions support variables that are declared by any
# #        ARG instructions that occur before the first FROM"
# ARG DEPLOY_MACHINE_TAG=3.16-2.7.7-2.3.26
# ARG DEPLOY_MACHINE_IMAGE=alpine-ruby-bundler
# # Gem Cache is the same for devenv and deploy
# ARG GEM_CACHE_TAG=latest
# ARG GEM_CACHE_IMAGE=sample-login-capybara-rspec-gems

# #--- Dev Environment ---
# # Before any checks stages so that we can always build a dev env
# # ASSUME source is docker volumed into the image
# FROM ${GEM_CACHE_IMAGE}:${GEM_CACHE_TAG} AS devenv

# # Start devenv in (command line) shell
# CMD sh

# #--- Deploy Gem Cache Stage ---
# # This stage exists because ARG values can not be used in the
# # COPY --from= statement
# FROM ${GEM_CACHE_IMAGE}:${GEM_CACHE_TAG} AS deploy-gem-cache

# #--- Deploy Stage ---
# FROM ${DEPLOY_MACHINE_IMAGE}:${DEPLOY_MACHINE_TAG} AS deploy

# # Throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1 \
#   # Run as deployer USER instead of as root
#   && adduser -D deployer
# USER deployer

# # Copy the built gems directory from deploy gem cache
# COPY --from=deploy-gem-cache --chown=deployer /usr/local/bundle/ /usr/local/bundle/
# # Copy the app source to /app
# WORKDIR /app
# COPY --chown=deployer . /app/

# # Run the tests but allow override
# CMD ./script/runtests

# ============= ORIGINAL =============
# sample-login-capybara-rspec
### Base Image ###
FROM ruby:2.7.7-alpine AS ruby-alpine

### Builder Stage ###
FROM ruby-alpine AS builder
# Alpine needs build-base for building native extensions
RUN apk --update add --virtual build-dependencies build-base

# Use the same version of Bundler in the Gemfile.lock
RUN gem install bundler:2.3.26
WORKDIR /app
# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

### Dev Environment ###
# Before any checks stages so that we can always build a dev env
# ASSUME source is docker volumed into the image
FROM builder AS devenv
# Add git and vim at least
RUN apk add --no-cache git
RUN apk add --no-cache vim
# Start devenv in (command line) shell
CMD sh

### Deploy Stage ###
FROM ruby-alpine AS deploy
# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Run as deployer USER instead of as root
RUN adduser -D deployer
USER deployer

# Copy the built gems directory from builder layer
COPY --from=builder --chown=deployer /usr/local/bundle/ /usr/local/bundle/
# Copy the app source to /app
WORKDIR /app
COPY --chown=deployer . /app/

# Run the tests but allow override
CMD ./script/runtests
