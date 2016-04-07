
install.packages("tm")
install.package("wordcloud")
require(tm)
require(twitteR)
require(RCurl)
require(wordcloud)
library(RCurl)
options(RCurlOptions = list(cainfo=systemfile("CurlSSL","cacert.pem",package= "RCurl")))
library(twitteR)

## Twitter Keys go here

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
apiKey <- ""
apiSecret <- ""
                                                         
accessToken <- ""
accessTokenSecret<- ""
 
 
##Set UP handshake connection

setup_twitter_oauth(apiKey, apiSecret, accessToken, accessTokenSecret)
                                                         
##Fetching most recent 1000 tweets 
                                                  
Bern <- searchTwitter('Bernie + Sanders', lang ="en", n=1000, resultType="recent" )

class(Bern)
Bern_text <- sapply (Bern, function(x) x$getText())

str(Bern_text)

##Cleaning 

Bern_corpus <- Corpus(VectorSource(Bern_text))
Bern_clean <- tm_map(Bern_corpus, removePunctuation)                                                       
Bern_clean <- tm_map(Bern_clean, content_transformer(tolower))
Bern_clean <- tm_map(Bern_clean, removeWords, stopwords("english"))
Bern_Clear <- tm_map(Bern_clean, removeNumbers)
Bern_Clean <- tm_map(Bern_clean, removeNumbers)
Bern_clean <- tm_map(Bern_clean, stripWhitespace)
Bern_clean <- tm_map(Bern_clean, removeWords, c("Bernie", "Sanders"))

##Generating WordCloud 
wordcloud(Bern_clean)