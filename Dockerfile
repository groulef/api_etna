FROM ruby:2.3.0

RUN DEBIAN_=noninteractive

RUN apt-get update 

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y mysql-server mysql-client

RUN service mysql start && mysql -uroot -proot -e "CREATE DATABASE tcm_rest"
RUN service mysql start && mysql -uroot -proot -e "SHOW DATABASES"

RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y ruby gem 
RUN gem install bundler

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
#COPY . $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

COPY bdd.sql* $APP_HOME/
RUN service mysql start && mysql -uroot -proot tcm_rest < bdd.sql
#RUN service mysql start && mysql -uroot -proot -e "use tcm_rest; SELECT * FROM user;"
#; source bdd.sql;"

#upload source
COPY . $APP_HOME

# Start server
ENV PORT 3000
#EXPOSE 3306
EXPOSE 3000
CMD /etc/init.d/mysql start && bundle exec puma

# run : docker build -t img_ruby . && winpty docker run -it --name="API_REST" --rm -p 3000:3000 img_ruby
