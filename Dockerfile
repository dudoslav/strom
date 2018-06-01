FROM ruby:2.2

RUN apt-get update -qq && apt-get install -y build-essential

ENV downloadDir="/downloads"
ENV videoDir="/videos"

RUN mkdir -p $downloadDir $videoDir

VOLUME ${downloadDir}
VOLUME ${videoDir}

ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/  
RUN bundle install
ADD . $APP_HOME

EXPOSE 8080

CMD [ "bundle", "exec", "rackup", "-p", "8080", "-o", "0.0.0.0" ]
