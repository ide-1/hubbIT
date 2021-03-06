FROM ruby:2.5.1
#
RUN apt-get update && apt-get install -y \
#Packages
net-tools netcat

RUN apt-get clean

#Install gems
RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install

# Database defaults
ENV DATABASE_NAME hubbit_dev
ENV DATABASE_HOST 0.0.0.0
ENV DATABASE_USER hubbit
ENV DATABASE_PASSWORD iamapassword
ENV DATABASE_ADAPTER mysql2

ENV OAUTH_ID id
ENV OAUTH_SECRET secret
ENV CLIENT_CREDENTIALS key
ENV ACCOUNT_ADDRESS http://localhost:8081
ENV API_KEY key

# Start server
ENV RAILS_ENV development
ENV RACK_ENV development
ENV SECRET_KEY_BASE secret
ENV PORT 3001
EXPOSE 3001

#Upload source
COPY . /app
RUN useradd ruby
RUN chown -R ruby /app
USER ruby

CMD ["sh", "start.sh"]
